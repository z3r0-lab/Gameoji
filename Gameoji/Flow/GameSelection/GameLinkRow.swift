//
//  GameLinkRow.swift
//  Gameoji
//
//  Created by Бағжан Артыкбаев on 25.04.2025.
//

import SwiftUI

struct GameLinkRow: View {
    let game: Game
    
    var body: some View {
        VStack {
            NavigationLink(destination: EmptyView()) {
                HStack {
                    Text(game.title)
                        .foregroundStyle(.white)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.white)
                }
                .padding(.bottom, 5)
            }
            Divider()
                .background(.white.opacity(0.7))
        }
    }
}
