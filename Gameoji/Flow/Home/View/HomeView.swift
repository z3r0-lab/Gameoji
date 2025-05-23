//
//  HomeView.swift
//  Gameoji
//
//  Created by Бағжан Артыкбаев on 25.04.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.customDarkBlue, .customPurple],
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text(viewModel.gameTitle)
                    .font(.system(size: 70, weight: .bold))
                    .foregroundStyle(.white)
                
                Text(viewModel.gameSubtitle)
                    .font(.title3)
                    .foregroundStyle(.white.opacity(0.5))
                
                Spacer()
                
                VStack(spacing: 32) {
                    NavigationLink(destination: GameSelectionView()) {
                        Text("Start the game")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundStyle(.white)
                            .padding(.vertical, 20)
                            .padding(.horizontal, 40)
                            .background(.gray.opacity(0.1))
                            .clipShape(.rect(cornerRadius: 12))
                    }
                    
                    NavigationLink(destination: AboutUsView()) {
                        Text("About the game")
                            .font(.system(size: 17, weight: .medium))
                            .foregroundStyle(.white.opacity(0.7))
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

