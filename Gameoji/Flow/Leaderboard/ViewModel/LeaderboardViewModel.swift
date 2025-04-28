//
//  LeaderboardViewModel.swift
//  Gameoji
//
//  Created by Бағжан Артыкбаев on 26.04.2025.
//

import FirebaseFirestore

class LeaderboardViewModel: ObservableObject {
    @Published var players: [Player] = []
    @Published var isLoading = false
    
    private let db = Firestore.firestore()
    
    func fetchPlayers() {
        isLoading = true
        db.collection("leaderboard")
            .order(by: "score", descending: true)
            .getDocuments { snapshot, err in
                if let err = err {
                    print("Ошибка загрузки игроков: \(err.localizedDescription)")
                    self.isLoading = false
                    return
                }
                
                guard let doc = snapshot?.documents else { return }
                
                self.players = doc.compactMap({ doc -> Player? in
                    let name = doc["name"] as? String ?? ""
                    let score = doc["score"] as? Int ?? 0
                    
                    return Player(name: name, score: score)
                })
                
                self.isLoading = false
            }
    }
}
