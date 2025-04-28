//
//  CharactersListView.swift
//  Gameoji
//
//  Created by Бағжан Артыкбаев on 26.04.2025.
//

import SwiftUI

struct CharactersListView: View {
    var title: String
    var subtitle: String
    @FocusState private var isSearchFieldFocused: Bool
    @StateObject private var viewModel = CharactersListViewModel()
    @State private var isSearching = false
    @State private var searchText = ""
    @State private var selectedHeroID: String? = nil
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.customPurple, .customChery],
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    Text(subtitle)
                    
                    Text("Characters")
                        .font(.title).bold()
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                if isSearching {
                    TextField("Search characters...", text: $searchText)
                        .padding()
                        .background(.white.opacity(0.3))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .foregroundStyle(.white)
                        .submitLabel(.search)
                        .focused($isSearchFieldFocused)
                        .autocorrectionDisabled()
                        .onSubmit {
                            scrollToFirstMatch()
                        }
                }
                
                if viewModel.isLoading {
                    VStack {
                        Spacer()
                        ProgressView("Loading Characters...")
                            .foregroundStyle(.white)
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    ScrollViewReader { proxy in
                        ScrollView {
                            VStack(spacing: 16) {
                                ForEach(viewModel.heroes) { hero in
                                    CharactersCardView(name: hero.name, imageName: hero.imageUrl, desription: hero.description)
                                        .id(hero.id)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 10)
                            .padding(.bottom, 20)
                        }
                        .onChange(of: selectedHeroID) {
                            if let id = selectedHeroID {
                                withAnimation {
                                    proxy.scrollTo(id, anchor: .top)
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle(title)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    withAnimation {
                        isSearching.toggle()
                    }
                    if isSearching {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            isSearchFieldFocused = true
                        }
                    } else {
                        isSearching = false
                    }
                }) {
                    Image(systemName: isSearching ? "xmark" : "magnifyingglass")
                        .foregroundStyle(.white.opacity(0.4))
                }
            }
        }
        .onAppear {
            viewModel.fetchUser(forGame: title)
        }
    }
    
    private func scrollToFirstMatch() {
        if let match = viewModel.heroes.first(where: {$0.name.localizedCaseInsensitiveContains(searchText) }) {
            selectedHeroID = match.id
        } else {
            selectedHeroID = nil
        }
    }
}

