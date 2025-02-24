//
//  Character.swift
//  RickAndMortyExercise
//
//  Created by Kevin Tarr on 2/20/25.
//

import Foundation

struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let species: String
    let status: String
    let origin: Origin
    let type: String?
    let image: String
    let created: String
    
    struct Origin: Codable {
        let name: String
    }
}
