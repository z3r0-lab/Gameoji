//
//  UploadCharactersView.swift
//  Gameoji
//
//  Created by Бағжан Артыкбаев on 26.04.2025.
//

import SwiftUI
import FirebaseFirestore

struct UploadCharactersView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Загрузка персонажей")
                .font(.largeTitle)
                .padding()
            
            Button(action: {
                uploadCharacters()
            }) {
                Text("Загрузить персонажей в Firestore")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
            }
        }
    }
    
    func uploadCharacters() {
        let characters: [CharacterModel1] = [
            // The Witcher 3
            CharacterModel1(id: UUID().uuidString, name: "Geralt", game: "The Witcher", emoji: ["⚔️", "🐺", "🧪"], correct: "Geralt", answer: ["Geralt", "Yennefer", "Ciri", "Triss"]),
            CharacterModel1(id: UUID().uuidString, name: "Ciri", game: "The Witcher", emoji: ["👸", "⚡️", "🗡️"], correct: "Ciri", answer: ["Ciri", "Geralt", "Yennefer", "Vesemir"]),
            CharacterModel1(id: UUID().uuidString, name: "Yennefer", game: "The Witcher", emoji: ["🧙‍♀️", "🖤", "🔥"], correct: "Yennefer", answer: ["Yennefer", "Triss", "Ciri", "Keira Metz"]),
            CharacterModel1(id: UUID().uuidString, name: "Triss", game: "The Witcher", emoji: ["🧙‍♀️", "❤️", "🌹"], correct: "Triss", answer: ["Triss", "Yennefer", "Ciri", "Philippa"]),
            CharacterModel1(id: UUID().uuidString, name: "Vesemir", game: "The Witcher", emoji: ["🧔", "🐺", "⚔️"], correct: "Vesemir", answer: ["Vesemir", "Geralt", "Emhyr", "Lambert"]),
            CharacterModel1(id: UUID().uuidString, name: "Dandelion", game: "The Witcher", emoji: ["🎵", "🎸", "💜"], correct: "Dandelion", answer: ["Dandelion", "Geralt", "Emhyr", "Vesemir"]),
            CharacterModel1(id: UUID().uuidString, name: "Emhyr", game: "The Witcher", emoji: ["👑", "🦅", "⚔️"], correct: "Emhyr", answer: ["Emhyr", "Geralt", "Vesemir", "Dijkstra"]),
            CharacterModel1(id: UUID().uuidString, name: "Lambert", game: "The Witcher", emoji: ["🧔", "🛡️", "⚔️"], correct: "Lambert", answer: ["Lambert", "Eskel", "Geralt", "Vesemir"]),
            CharacterModel1(id: UUID().uuidString, name: "Eskel", game: "The Witcher", emoji: ["🧔", "🐺", "⚡️"], correct: "Eskel", answer: ["Eskel", "Lambert", "Vesemir", "Geralt"]),
            CharacterModel1(id: UUID().uuidString, name: "Keira Metz", game: "The Witcher", emoji: ["🔮", "🧙‍♀️", "🌟"], correct: "Keira Metz", answer: ["Keira Metz", "Yennefer", "Triss", "Philippa"]),

            // Mortal Kombat
            CharacterModel1(id: UUID().uuidString, name: "Scorpion", game: "Mortal Kombat", emoji: ["🦂", "🔥", "🗡️"], correct: "Scorpion", answer: ["Scorpion", "Sub-Zero", "Raiden", "Liu Kang"]),
            CharacterModel1(id: UUID().uuidString, name: "Sub-Zero", game: "Mortal Kombat", emoji: ["❄️", "🧊", "🥋"], correct: "Sub-Zero", answer: ["Sub-Zero", "Scorpion", "Kung Lao", "Sonya Blade"]),
            CharacterModel1(id: UUID().uuidString, name: "Raiden", game: "Mortal Kombat", emoji: ["⚡️", "👲", "🌩️"], correct: "Raiden", answer: ["Raiden", "Scorpion", "Kano", "Liu Kang"]),
            CharacterModel1(id: UUID().uuidString, name: "Liu Kang", game: "Mortal Kombat", emoji: ["🥋", "🐉", "🔥"], correct: "Liu Kang", answer: ["Liu Kang", "Raiden", "Johnny Cage", "Scorpion"]),
            CharacterModel1(id: UUID().uuidString, name: "Sonya Blade", game: "Mortal Kombat", emoji: ["👱‍♀️", "🪖", "🔫"], correct: "Sonya Blade", answer: ["Sonya Blade", "Cassie Cage", "Jade", "Kitana"]),
            CharacterModel1(id: UUID().uuidString, name: "Johnny Cage", game: "Mortal Kombat", emoji: ["🕶️", "🎬", "🥊"], correct: "Johnny Cage", answer: ["Johnny Cage", "Kano", "Scorpion", "Liu Kang"]),
            CharacterModel1(id: UUID().uuidString, name: "Kitana", game: "Mortal Kombat", emoji: ["👸", "🌬️", "🥷"], correct: "Kitana", answer: ["Kitana", "Jade", "Sonya Blade", "Mileena"])
        ]

        let db = Firestore.firestore()

        for character in characters {
            let data: [String: Any] = [
                "id": character.id,
                "name": character.name,
                "game": character.game,
                "emoji": character.emoji,
                "correct": character.correct,
                "answer": character.answer
            ]

            db.collection("characters").document(character.id).setData(data) { error in
                if let error = error {
                    print("Ошибка при загрузке: \(error.localizedDescription)")
                } else {
                    print("Персонаж \(character.name) успешно загружен!")
                }
            }
        }
    }
}

// CharacterModel должен быть Codable и Identifiable
struct CharacterModel1: Identifiable, Codable {
    var id: String
    var name: String
    var game: String
    var emoji: [String]
    var correct: String
    var answer: [String]
}

