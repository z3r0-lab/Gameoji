//
//  CharacterModel.swift
//  Gameoji
//
//  Created by Бағжан Артыкбаев on 26.04.2025.
//

import Foundation

struct CharacterModel: Identifiable, Codable, Equatable {
    var id: String
    var name: String
    var game: String
    var emoji: [String]
    var correct: String
    var answer: [String]
}
