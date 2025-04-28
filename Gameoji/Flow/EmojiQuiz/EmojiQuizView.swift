//
//  EmojiQuizView.swift
//  Gameoji
//
//  Created by Бағжан Артыкбаев on 25.04.2025.
//

import SwiftUI
import FirebaseFirestore

struct EmojiQuizView: View {
    var title: String
    
    @Environment(\.dismiss) var dismiss
    
    @State private var progress: Double = 0.0
    @State private var currentIndex: Int = 0
    @State private var score: Int = 0
    @State private var showAlert = false
    @State private var playerName = ""
    @State private var wrongAnswerAnimation = false
    @State private var isExitGame = false
    @State private var shuffledAnswers: [String] = []
    
    @StateObject private var viewModel = QuizViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            LinearGradient(colors: [.customPurple, .customChery],
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack {
                Text(title)
                    .foregroundStyle(.white)
                    .font(.system(size: 40, weight: .bold))
                    .padding(.top, 40)
                
                Spacer().frame(height: 100)
                
                if viewModel.characters.indices.contains(currentIndex) {
                    let character = viewModel.characters[currentIndex]
                    
                    VStack(spacing: 20) {
                        VStack {
                            Text("Guess the character 🧐")
                                .foregroundStyle(.white)
                                .font(.title3)
                            Divider().background(.white)
                        }
                        .padding(.horizontal, 60)
                        
                        Text(character.emoji.joined(separator: " "))
                            .font(.system(size: 50))
                            .modifier(ShakeEffect(animatableData: CGFloat(wrongAnswerAnimation ? 1 : 0)))
                    }
                    
                    VStack(spacing: 15) {
                        ForEach(0..<2) { row in
                            HStack(spacing: 15) {
                                ForEach(0..<2) { col in
                                    let index = row * 2 + col
                                    if index < shuffledAnswers.count {
                                        let answer = shuffledAnswers[index]
                                        Button(action: {
                                            handleAnswerSelection(answer, correctAnswer: character.correct)
                                        }) {
                                            Text(answer)
                                                .padding()
                                                .frame(maxWidth: .infinity)
                                                .frame(height: 60)
                                                .foregroundStyle(.white)
                                                .background(.gray.opacity(0.3))
                                                .clipShape(.rect(cornerRadius: 15))
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.top)
                    .padding(.horizontal, 30)
                } else {
                    ProgressView()
                        .tint(.white)
                        .scaleEffect(1.5)
                }
                Spacer(minLength: 140)
            }
            
            SemiCircularProgressView(value: progress, score: score)
                .frame(height:  50)
                .padding(.bottom, 24)
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(
            trailing: Button(action: {
                isExitGame = true
            }) {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .foregroundStyle(.white)
            }
        )
        .alert("Game over", isPresented: $showAlert) {
            TextField("Enter your name", text: $playerName)
            
            Button("Save") {
                viewModel.saveScore(playerName: playerName, score: score) {
                    dismiss()
                }
            }
            
            Button("Cancel", role: .cancel) { dismiss() }
        } message: {
            Text("Your score: \(score)")
        }
        .alert("Exit Game", isPresented: $isExitGame) {
            Button("Exit") {
                dismiss()
            }
            
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("If you exit the game, you will lose your score.")
        }
        .onAppear {
            viewModel.fetchCharacters(forGame: title)
            startTimer()
        }
        .onChange(of: viewModel.characters) { 
            shuffleAnswers()
        }
    }
    
    private func handleAnswerSelection(_ selected: String, correctAnswer: String) {
        if selected == correctAnswer {
            score += 1
            nextCharacter()
        } else {
            withAnimation(.default) {
                wrongAnswerAnimation = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                wrongAnswerAnimation = false
            }
        }
    }
    
    private func nextCharacter() {
        if currentIndex < viewModel.characters.count - 1 {
            currentIndex += 1
            shuffleAnswers()
        } else {
            currentIndex = 0
            shuffleAnswers()
        }
    }
    
    private func shuffleAnswers() {
        if viewModel.characters.indices.contains(currentIndex) {
            shuffledAnswers = viewModel.characters[currentIndex].answer.shuffled()
        }
    }
    
    private func startTimer() {
        let totalDuration: TimeInterval = 60
        let interval: TimeInterval = 0.1
        var elapsed: TimeInterval = 0
        
        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            elapsed += interval
            let percent = min(elapsed/totalDuration, 1.0)
            withAnimation(.linear(duration: interval)) {
                self.progress = percent
            }
            if percent >= 1.0 {
                timer.invalidate()
                DispatchQueue.main.async {
                    showAlert = true
                }
            }
        }
    }
}

struct SemiCircularProgressView: View {
    var value: Double
    var score: Int
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let diameter = width
            let lineWidth: CGFloat = 8
            let degrees: Double = 180.0
    
            let angle = Angle(degrees: 180 + (180 * value))
            let emojiRadius = (diameter / 2) - (lineWidth / 2)
            let x = cos(angle.radians) * emojiRadius
            let y = sin(angle.radians) * emojiRadius
            
            let totalSeconds = 60
            let secondsLeft = Int((1.0 - value) * Double(totalSeconds))
            
            let emoji: String = {
                switch value {
                case 0.0..<0.5: return "🙂"
                case 0.5..<0.8: return "😐"
                case 0.8...1.0: return "☹️"
                default: return "🙂"
                }
            }()
            
            ZStack {
                Circle()
                    .fill(.ultraThinMaterial.opacity(0.5))
                    .frame(height: diameter-8)
                
                Circle()
                    .trim(from: 0, to: 0.5)
                    .stroke(.gray.opacity(0.3), lineWidth: lineWidth)
                    .rotationEffect(.degrees(degrees))
                    .frame(width: diameter, height: diameter)
                
                Circle()
                    .trim(from: 0, to: value * 0.5)
                    .stroke(.green, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                    .rotationEffect(.degrees(degrees))
                    .frame(width: diameter, height: diameter)
                
                Text(emoji)
                    .font(.system(size: 40))
                    .offset(x: CGFloat(x), y: CGFloat(y))
                    .animation(.easeInOut(duration: 0.2), value: value)
                
                VStack {
                    Text("00:\(String(format: "%02d", secondsLeft))")
                        .font(.system(size: 25, weight: .light))
                        .foregroundStyle(.white)
                        .padding()
                    
                    Text("Score: \(self.score)")
                        .font(.title2).bold()
                        .foregroundStyle(.white)
                }
                .offset(y: -diameter/4)
                
            }
            .frame(width: width, height: diameter / 2, alignment: .top)
        }
        .frame(height: UIScreen.main.bounds.width / 2)
        .frame(maxWidth: .infinity)
    }
}

struct ShakeEffect: GeometryEffect {
    var animatableData: CGFloat
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        let translation = 10 * sin(animatableData * .pi * 4)
        return ProjectionTransform(CGAffineTransform(translationX: translation, y: 0))
    }
}
