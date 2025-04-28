//
//  GameCardView.swift
//  Gameoji
//
//  Created by Бағжан Артыкбаев on 26.04.2025.
//

import SwiftUI

struct GameCardView: View {
    let game: Game
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(game.imageTitle)
                .resizable()
                .scaledToFill()
                .frame(height: 180)
                .clipShape(.rect(cornerRadius: 10))
            
            VStack {
                Spacer()
                NavigationLink(destination: EmojiQuizView(title: game.title)) {
                    HStack {
                        Text(game.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(.leading, 20)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.white)
                            .padding(.trailing, 20)
                    }
                    .frame(height: 60)
                    .background(
                        Color.gray.opacity(0.7)
                            .blur(radius: 0.5)
                    )
                    .clipShape(.rect(cornerRadius: 20))
                    .padding(.bottom, 10)
                    .padding(.horizontal, 10)
                }
                
            }
            NavigationLink(destination: CharactersListView(title: game.title, subtitle: game.subtitle)) {
                Image(systemName: "info.circle")
                    .foregroundStyle(.white)
                    .padding(10)
            }
        }
        .frame(height: 180)
        .background(.black.opacity(0.3))
        .cornerRadius(20)
        .shadow(radius: 5)
        .padding(.horizontal)
        
    }
}


