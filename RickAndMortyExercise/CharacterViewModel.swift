//
//  CharacterViewModel.swift
//  RickAndMortyExercise
//
//  Created by Kevin Tarr on 2/20/25.
//

import SwiftUI
import Combine

@MainActor
class CharacterViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var selectedStatus: String = ""
    @Published var selectedSpecies: String = ""
    @Published var selectedType: String = ""
    @Published var isDefaultList: Bool = true
    @Published var currentPage: Int = 1
    @Published var canLoadMore: Bool = false

    let statusOptions = ["", "Alive", "Dead", "unknown"]
    let speciesOptions = ["", "Human", "Alien", "Humanoid", "Robot", "Animal"]
    let typeOptions = ["", "Disease", "Parasite", "Mythological Creature"]
    
    private let characterService = CharacterService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] text in
                Task {
                    await self?.resetAndSearchCharacters()
                }
            }
            .store(in: &cancellables)
        
        Publishers.CombineLatest3($selectedStatus, $selectedSpecies, $selectedType)
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] _, _, _ in
                Task {
                    await self?.resetAndSearchCharacters()
                }
            }
            .store(in: &cancellables)

        Task {
            await loadDefaultCharacters()
        }
    }
    
    func loadDefaultCharacters() async {
        isLoading = true
        errorMessage = nil
        currentPage = 1
        do {
            characters = try await characterService.fetchCharacters(searchText: "", page: currentPage)
            canLoadMore = !characters.isEmpty
            isDefaultList = true
        } catch {
            errorMessage = "Failed to load default characters."
        }
        isLoading = false
    }
    
    func searchCharacters() async {
        guard !isLoading else { return }
        guard !searchText.isEmpty || !selectedStatus.isEmpty || !selectedSpecies.isEmpty || !selectedType.isEmpty else {
            await loadDefaultCharacters()
            return
        }
        isLoading = true
        errorMessage = nil
        do {
            let newCharacters = try await characterService.fetchCharacters(
                searchText: searchText,
                status: selectedStatus,
                species: selectedSpecies,
                type: selectedType,
                page: currentPage
            )
            characters.append(contentsOf: newCharacters)
            canLoadMore = !newCharacters.isEmpty
            if characters.isEmpty {
                errorMessage = "No characters found for the selected filters."
            }
            isDefaultList = false
        } catch {
            errorMessage = "Failed to load characters due to a network or server error."
        }
        isLoading = false
    }
    
    func resetAndSearchCharacters() async {
        characters = []
        currentPage = 1
        await searchCharacters()
    }

    func loadMoreCharacters() async {
        guard canLoadMore, !isLoading else { return }
        currentPage += 1
        await searchCharacters()
    }

    func clearFilters() {
        selectedStatus = ""
        selectedSpecies = ""
        selectedType = ""
        searchText = ""
        Task {
            await loadDefaultCharacters()
        }
    }
}
