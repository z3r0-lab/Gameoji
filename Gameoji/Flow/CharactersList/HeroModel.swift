//
//  HeroModel.swift
//  Gameoji
//
//  Created by Бағжан Артыкбаев on 27.04.2025.
//

import Foundation

struct HeroModel: Identifiable, Codable {
    var id: String
    var name: String
    var description: String
    var imageUrl: String
    var game: String
}
