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
            LinearGradient(colors: [.customDarkBlue, .customChery],
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
            
            Text("This game was made with ❤️ for game lovers!")
                .multilineTextAlignment(.center)
                .padding()
                .foregroundStyle(.white)
        }
        .navigationTitle("About").foregroundStyle(.white)
        
        .navigationBarTitleDisplayMode(.inline)
    }
}
