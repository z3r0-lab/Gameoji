//
//  Game.swift
//  Gameoji
//
//  Created by Бағжан Артыкбаев on 25.04.2025.
//

import Foundation

struct Game: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String
    let imageTitle: String
}


