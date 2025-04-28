//
//  QuizViewModel.swift
//  Gameoji
//
//  Created by Бағжан Артыкбаев on 26.04.2025.
//

import FirebaseFirestore

class QuizViewModel: ObservableObject {
    @Published var characters: [CharacterModel] = []
    
    private let db = Firestore.firestore()
    
    func fetchCharacters(forGame game: String) {
        db.collection("characters")
            .whereField("game", isEqualTo: game)
            .getDocuments { snapshot, err in
            if let err = err {
                print("Ошибка при получении данных: \(err.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            self.characters = documents.compactMap { doc in
                let data = doc.data()
                
                return CharacterModel(
                    id: doc.documentID,
                    name: doc["name"] as? String ?? "",
                    game: doc["game"] as? String ?? "",
                    emoji: data["emoji"] as? [String] ?? [],
                    correct: data["correct"] as? String ?? "",
                    answer: data["answer"] as? [String] ?? []
                )
            }
        }
    }
    
    func saveScore(playerName: String, score: Int, onSuccess: (() -> Void)?) {
        let trimmedName = playerName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return }
        
        let db = Firestore.firestore()
        
        let data: [String: Any] = [
            "name": trimmedName,
            "score": score
        ]
        
        db.collection("leaderboard").document().setData(data) { err in
            if let err = err {
                print("Ошибка при сохранении данных: \(err.localizedDescription)")
            } else {
                print("Результат успешно сохранён!")
                onSuccess?()
            }
        }
    }
}
