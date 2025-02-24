//
//  RickAndMortyExerciseApp.swift
//  RickAndMortyExercise
//
//  Created by Kevin Tarr on 2/20/25.
//

import SwiftUI

@main
struct RickAndMortyExerciseApp: App {
    @StateObject private var viewModel = CharacterViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
