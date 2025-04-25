//
//  HomeViewModel.swift
//  Gameoji
//
//  Created by Бағжан Артыкбаев on 25.04.2025.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var gameTitle: String = "Gameoji"
    @Published var gameSubtitle: String = "Guess the Game by Emoji"
}
