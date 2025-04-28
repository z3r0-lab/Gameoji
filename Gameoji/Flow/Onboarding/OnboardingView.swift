//
//  OnboardingView.swift
//  Gameoji
//
//  Created by Бағжан Артыкбаев on 28.04.2025.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.customPurple, .customDarkBlue], startPoint: .leading, endPoint: .trailing)
                .ignoresSafeArea()
            
            TabView {
                OnboardingPage(title: "Welcome to Gameoji!", subtitle: "Guess your favorite heroes using emojis.", imageName: "logo")
                MiddleOnboardingPage(title: "Three emojis — one character!", subtitle: "Pick the correct answer and earn points.", emojisName: ["⚔️", "🐉", "👨🏻"])
                MiddleOnboardingPage(title: "Play in your favorite universes.", subtitle: "Dive into the worlds of Mortal Kombat and The Witcher.", emojisName: ["🥷🏻", "🗡️"])
                LastOnboardingPage()
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .animation(.easeInOut, value: UUID())
        }
    }
}

struct OnboardingPage: View {
    var title: String
    var subtitle: String
    var imageName: String
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .foregroundStyle(.white)
                
                Text(title)
                    .font(.title)
                    .bold()
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                
                Text(subtitle)
                    .font(.body)
                    .foregroundStyle(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                Spacer()
            }
            .padding()
        }
    }
}

struct MiddleOnboardingPage: View {
    var title: String
    var subtitle: String
    var emojisName: [String]
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            HStack(spacing: 10) {
                ForEach(emojisName, id: \.self) { emoji in
                    Text(emoji)
                        .font(.system(size: 80))
                }
            }
            .padding(.horizontal, 20)
            
            Text(title)
                .font(.title)
                .bold()
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
            
            Text(subtitle)
                .font(.body)
                .foregroundStyle(.white.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Spacer()
        }
        .padding()
    }
}

struct LastOnboardingPage: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("Ready to start?")
                .font(.title)
                .bold()
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
            
            NavigationLink(destination: HomeView().onAppear {
                UserDefaults.standard.set(true, forKey: String(describing: OnboardingView().self))
            }) {
                Image("startButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundStyle(.white)
            }
            Spacer()
        }
        .padding()
    }
}


