//
//  GameSelectionViewModel.swift
//  Gameoji
//
//  Created by Бағжан Артыкбаев on 25.04.2025.
//

import Foundation

class GameSelectionViewModel: ObservableObject {
    @Published var games: [Game] = [
        Game(title: "The Witcher", subtitle: "The Witcher 3: Wild Hunt is a groundbreaking open-world role-playing game developed by CD Projekt Red and released in 2015. Based on the novels by Andrzej Sapkowski, the game follows Geralt of Rivia, a monster hunter navigating a war-torn, richly detailed fantasy world. Renowned for its deep storytelling, moral choices, and expansive world-building, The Witcher 3 has become a modern classic, earning numerous Game of the Year awards and influencing the RPG genre for years to come.", imageTitle: "theWitcher"),
        
        Game(title: "Mortal Kombat", subtitle: "Mortal Kombat is a legendary fighting game series created by Ed Boon and John Tobias, first released by Midway Games in 1992. Known for its brutal 'fatalities' and realistic digitized graphics, the game quickly became a pop culture icon. Today, Mortal Kombat is developed by NetherRealm Studios under Warner Bros., continuing its legacy in gaming and beyond.", imageTitle: "mortalCombat")
    ]
}
