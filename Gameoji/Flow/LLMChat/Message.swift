//
//  Message.swift
//  Gameoji
//
//  Created by Бағжан Артыкбаев on 28.04.2025.
//

import Foundation

struct Message: Identifiable, Codable {
    var id = UUID()
    let role: String
    let content: String
}
