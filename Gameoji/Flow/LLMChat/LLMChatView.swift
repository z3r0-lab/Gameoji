//
//  LLMChatView.swift
//  Gameoji
//
//  Created by Бағжан Артыкбаев on 28.04.2025.
//

import SwiftUI

struct LLMChatView: View {
    @State private var messages: [Message] = []
    @State private var inputText: String = ""
    
    var characterPrompt: String
    var characterName: String
    var characterImage: String
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.customPurple, .customChery], startPoint: .leading, endPoint: .trailing)
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    
                    VStack(spacing: 8) {
                        AsyncImage(url: URL(string: characterImage)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        } placeholder: {
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 100, height: 100)
                        }
                        
                        Text(characterName)
                            .font(.title2).bold()
                            .foregroundColor(.primary)
                    }
                    .padding(.top, 20)
                    
                    ScrollViewReader { scrollViewProxy in
                        ScrollView {
                            VStack(alignment: .leading, spacing: 12) {
                                ForEach(messages) { message in
                                    HStack(alignment: .top) {
                                        if message.role == "user" {
                                            Spacer()
                                            Text(message.content)
                                                .padding()
                                                .background(Color.blue.opacity(0.7))
                                                .foregroundColor(.white)
                                                .cornerRadius(12)
                                        } else {
                                            Text(message.content)
                                                .padding()
                                                .background(Color.gray.opacity(0.2))
                                                .foregroundColor(.black)
                                                .cornerRadius(12)
                                            Spacer()
                                        }
                                    }
                                }
                            }
                            .padding()
                        }
                        .onChange(of: messages.count) {
                            withAnimation {
                                scrollViewProxy.scrollTo(messages.last?.id, anchor: .bottom)
                            }
                        }
                    }
                    
                    HStack {
                        TextField("Message...", text: $inputText)
                            .padding(12)
                            .background(Color.white.opacity(0.3))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                            )
                            .frame(minHeight: 40)
                        
                        Button(action: sendMessage) {
                            Image(systemName: "paperplane.fill")
                                .font(.system(size: 24))
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                }
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    private func sendMessage() {
        let userMessage = Message(role: "user", content: inputText)
        messages.append(userMessage)
        inputText = ""
        
        callLLMAPI(userInput: inputText, characterPrompt: characterPrompt) { reply in
            if let reply = reply {
                DispatchQueue.main.async {
                    let assistantMessage = Message(role: "assistant", content: reply)
                    messages.append(assistantMessage)
                    inputText = ""
                }
            }
        }
    }
    
    private func callLLMAPI(userInput: String, characterPrompt: String, completion: @escaping (String?) -> Void) {
        LLMService.shared.sendMessage(userMessage: userInput, systemPrompt: characterPrompt, completion: completion)
    }
}
