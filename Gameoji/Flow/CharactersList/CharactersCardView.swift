//
//  CharactersCardView.swift
//  Gameoji
//
//  Created by Бағжан Артыкбаев on 26.04.2025.
//

import SwiftUI

struct CharactersCardView: View {
    var name: String
    var imageName: String
    var desription: String
    
    @State private var isChatPresented = false
    
    var body: some View {
        HStack(alignment: .top,spacing: 10) {
            AsyncImage(url: URL(string: imageName)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 130)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                Color.gray
                    .frame(width: 100, height: 130)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title2).bold()
                Text(desription)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
                HStack {
                    Spacer()
                    Button(action: {
                        isChatPresented = true
                    }) {
                        Text("TALK TO")
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(Color.white.opacity(0.1))
                            .foregroundColor(.black.opacity(0.6))
                            .font(.headline).bold()
                            .clipShape(.rect(cornerRadius: 15))
                    }
                }
            }
        }
        .padding()
        .background(.white.opacity(0.05))
        .clipShape(.rect(cornerRadius: 12))
        .navigationDestination(isPresented: $isChatPresented) {
            LLMChatView(characterPrompt: CharacterPrompt.prompt(for: name), characterName: name, characterImage: imageName)
        }
    }
}
