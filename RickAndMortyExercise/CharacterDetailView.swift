//
//  CharacterDetailView.swift
//  RickAndMortyExercise
//
//  Created by Kevin Tarr on 2/20/25.
//

import Foundation
import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(character.name)
                    .font(.largeTitle)
                    .bold()
                AsyncImage(url: URL(string: character.image)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fit)
                .transition(.scale)
                Text("Species: \(character.species)")
                Text("Status: \(character.status)")
                Text("Origin: \(character.origin.name)")
                if let type = character.type, !type.isEmpty {
                    Text("Type: \(type)")
                }
                Text("Created: \(formatDate(character.created))")
                Button(action: shareCharacter) {
                    Label("Share Character", systemImage: "square.and.arrow.up")
                }
            }
            .padding()
        }
    }
    
    private func shareCharacter() {
        guard let url = URL(string: character.image) else { return }
        let activityVC = UIActivityViewController(activityItems: [url, character.name], applicationActivities: nil)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(activityVC, animated: true, completion: nil)
        }
    }
    
    private func formatDate(_ dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            return displayFormatter.string(from: date)
        }
        return dateString
    }
}

