//
//  GameSelectionViewModel.swift
//  Gameoji
//
//  Created by Бағжан Артыкбаев on 25.04.2025.
//

import Foundation

class GameSelectionViewModel: ObservableObject {
    @Published var games: [Game] = [
        Game(title: "The Witcher 3"),
        Game(title: "Mortal Kombat")
    ]
}
