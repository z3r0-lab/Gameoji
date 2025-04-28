//
//  AboutUsView.swift
//  Gameoji
//
//  Created by Бағжан Артыкбаев on 25.04.2025.
//

import SwiftUI

struct AboutUsView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.customBlue, .customDark],
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
            VStack(alignment: .center, spacing: 20) {
                Spacer().frame(height: 10)
                Image("logo")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .scaledToFill()
                    .clipShape(.circle)
                
                Text("I created Gameoji to make discovering video game characters fun and easy. Through interactive emoji quizzes, you can test your knowledge, find new heroes, and share a love for gaming with me!")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundStyle(.white)
            
                Spacer()
                Text("Made with ❤️ for game lovers")
                    .bold()
            }
            .padding()
            
            
        }
        .navigationTitle("About").foregroundStyle(.white)
        .navigationBarTitleDisplayMode(.inline)
    }
}

