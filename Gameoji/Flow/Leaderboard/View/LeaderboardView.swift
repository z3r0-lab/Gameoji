//
//  LeaderboardView.swift
//  Gameoji
//
//  Created by Бағжан Артыкбаев on 26.04.2025.
//

import SwiftUI

struct LeaderboardView: View {
    
    @StateObject private var viewModel = LeaderboardViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.customPurple, .customChery], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 16) {
                VStack(spacing: 5) {
                    Text("🏆")
                        .font(.system(size: 70))
                    Text("Top winners")
                        .foregroundStyle(.white)
                        .font(.system(size: 45, weight: .bold))
                    Text("The fastest and smartest players")
                        .foregroundStyle(.white.opacity(0.5))
                }
                .padding(.top, 20)
                
                if viewModel.isLoading {
                    VStack {
                        Spacer()
                        ProgressView("Loading Leaderboard...")
                            .foregroundStyle(.white)
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5)
                        Spacer()
                    }
                } else {
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(Array(viewModel.players.enumerated()), id: \.1.id) { index, player in
                                LeaderboardCardView(rank: index + 1, player: player)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
            }
            .onAppear {
                viewModel.fetchPlayers()
            }
        }
        
    }
}

struct LeaderboardCardView: View {
    let rank: Int
    let player: Player
    
    var rankColor: Color {
        switch rank {
        case 1: return Color.yellow.opacity(0.9)
        case 2: return Color.gray
        case 3: return Color.brown
        default: return Color.white.opacity(0.1)
        }
    }
    
    var body: some View {
        HStack {
            Text(rankSymbol(for: rank))
                .font(.title2)
                .foregroundStyle(.white)
            
            Text(player.name)
                .font(.title2)
                .foregroundStyle(.white)
            Spacer()
            Text("\(player.score)")
                .font(.headline)
                .foregroundStyle(.white)
        }
        .padding()
        .background(rankColor)
        .cornerRadius(15)
    }
    
    func rankSymbol(for rank: Int) -> String {
        switch rank {
        case 1: return "🥇"
        case 2: return "🥈"
        case 3: return "🥉"
        default: return "\(rank)"
        }
    }
}


