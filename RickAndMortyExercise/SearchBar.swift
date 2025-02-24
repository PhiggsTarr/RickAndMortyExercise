//
//  SearchBar.swift
//  RickAndMortyExercise
//
//  Created by Kevin Tarr on 2/20/25.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var body: some View {
        TextField("Search Characters...", text: $text)
            .padding(8)
            .background(Color(.systemGray5))
            .cornerRadius(8)
            .padding()
            .accessibilityIdentifier("searchField")
            .accessibilityLabel("Search Characters")
    }
}


