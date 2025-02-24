//
//  CharacterService.swift
//  RickAndMortyExercise
//
//  Created by Kevin Tarr on 2/20/25.
//

import Foundation

class CharacterService {
    private let baseURL = "https://rickandmortyapi.com/api/character"
    
    func fetchCharacters(searchText: String, status: String = "", species: String = "", type: String = "", page: Int = 1) async throws -> [Character] {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.queryItems = [
            URLQueryItem(name: "name", value: searchText),
            URLQueryItem(name: "status", value: status.isEmpty ? nil : status),
            URLQueryItem(name: "species", value: species.isEmpty ? nil : species),
            URLQueryItem(name: "type", value: type.isEmpty ? nil : type),
            URLQueryItem(name: "page", value: "\(page)")
        ].compactMap { $0 }

        guard let url = urlComponents?.url else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode(APIResponse.self, from: data)
        return decodedResponse.results
    }
    
    struct APIResponse: Codable {
        let results: [Character]
    }
}

