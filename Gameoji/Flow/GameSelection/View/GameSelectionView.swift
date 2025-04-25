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
                    .padding(.top, 30)
                
                Spacer().frame(height: 50)
                
                VStack(spacing: 10) {
                    ForEach(viewModel.games, id: \.self) { game in
                        GameLinkRow(game: game)
                    }
                }
                .padding()
                Spacer()
            }
        }
    }
}




#Preview {
    NavigationStack {
        GameSelectionView()
    }
}
