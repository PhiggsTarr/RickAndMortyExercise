//
//  ContentView.swift
//  RickAndMortyExercise
//
//  Created by Kevin Tarr on 2/20/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CharacterViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                    .accessibilityIdentifier("searchField")
                FilterView(viewModel: viewModel)
                if viewModel.isLoading {
                    ProgressView()
                        .accessibilityIdentifier("loadingIndicator")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else if viewModel.characters.isEmpty && viewModel.isDefaultList {
                    VStack {
                        Text("Search for your favorite Rick and Morty characters!")
                            .font(.title3)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                        Text("Use the search bar or select filters to get started.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                } else {
                    List(viewModel.characters) { character in
                        NavigationLink(destination: CharacterDetailView(character: character)) {
                            HStack {
                                AsyncImage(url: URL(string: character.image)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .accessibilityLabel(Text("Image of \(character.name)"))
                                VStack(alignment: .leading) {
                                    Text("\(character.name)")
                                        .accessibilityIdentifier("CharacterName_\(character.name)_Cell_Number_\(character.id)")
                                    Text(character.species).font(.subheadline)
                                        .onAppear(){
                                            print("CharacterName_\(character.name)_Cell_Number_\(character.id)")
                                        }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Rick and Morty Search")
        }
    }
}



struct FilterView: View {
    @ObservedObject var viewModel: CharacterViewModel
    
    var body: some View {
        HStack {
            Picker("Status", selection: $viewModel.selectedStatus) {
                ForEach(viewModel.statusOptions, id: \ .self) { status in
                    Text(status).tag(status)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .accessibilityIdentifier("statusPicker")

            Picker("Species", selection: $viewModel.selectedSpecies) {
                ForEach(viewModel.speciesOptions, id: \ .self) { species in
                    Text(species).tag(species)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .accessibilityIdentifier("speciesPicker")

            Picker("Type", selection: $viewModel.selectedType) {
                ForEach(viewModel.typeOptions, id: \ .self) { type in
                    Text(type).tag(type)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .accessibilityIdentifier("typePicker")

            Button(action: {
                viewModel.clearFilters()
            }) {
                Text("Clear Filters")
                    .font(.caption)
                    .foregroundColor(.blue)
            }
            .accessibilityIdentifier("clearFiltersButton")
            .accessibilityLabel("Clear Filters")

        }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
