//
//  GameSelectionView.swift
//  Gameoji
//
//  Created by Бағжан Артыкбаев on 25.04.2025.
//

import SwiftUI

struct GameSelectionView: View {
    @StateObject private var viewModel = GameSelectionViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.customDarkBlue, .customPurple], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Text("🎮 Choose a Game")
                    .foregroundStyle(.white)
                    .font(.system(size: 40, weight: .bold))
                    .padding(.top, 10)
                
                Spacer().frame(height: 20)
                
                VStack(spacing: 30) {
                    ForEach(viewModel.games, id: \.self) { game in
                        GameCardView(game: game)
                    }
                    
                }
                .padding()
                Spacer()
            }
        }
        .navigationBarItems(trailing: NavigationLink(destination: LeaderboardView(), label: {
            Image(systemName: "trophy")
                .font(.title2)
                .foregroundStyle(.white.opacity(0.8))
        }))
    }
}

