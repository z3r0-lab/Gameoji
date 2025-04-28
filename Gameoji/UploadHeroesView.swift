//
//  UploadHeroesView.swift
//  Gameoji
//
//  Created by Бағжан Артыкбаев on 27.04.2025.
//

import SwiftUI
import FirebaseFirestore

struct UploadHeroesView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Upload Heroes")
                .font(.largeTitle)
                .padding()
            
            Button(action: {
                uploadHeroes()
            }) {
                Text("Upload heroes to Firestore")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
            }
        }
    }
    
    func uploadHeroes() {
        let heroes: [HeroModel1] = [
            // The Witcher 3
            HeroModel1(id: UUID().uuidString, game: "The Witcher", name: "Geralt", description: "A witcher, master swordsman, and monster hunter with superhuman abilities.", imageUrl: "https://i.postimg.cc/ZqkLhYpC/geralt.png"),
            HeroModel1(id: UUID().uuidString, game: "The Witcher", name: "Ciri", description: "Princess of Cintra with the ability to travel between worlds.", imageUrl: "https://i.postimg.cc/BQ19LZYd/Ciri.jpg"),
            HeroModel1(id: UUID().uuidString, game: "The Witcher", name: "Yennefer", description: "A powerful sorceress, known for her beauty, strength, and independence.", imageUrl: "https://i.postimg.cc/VLFTbS9Z/Yennefer.jpg"),
            HeroModel1(id: UUID().uuidString, game: "The Witcher", name: "Triss", description: "A kind-hearted sorceress and healer, loyal friend to witchers.", imageUrl: "https://i.postimg.cc/VvZC3WQH/Triss.jpg"),
            HeroModel1(id: UUID().uuidString, game: "The Witcher", name: "Vesemir", description: "The oldest witcher at Kaer Morhen, mentor and guardian to Geralt.", imageUrl: "https://i.postimg.cc/PxPp188W/Vesemir.jpg"),
            HeroModel1(id: UUID().uuidString, game: "The Witcher", name: "Dandelion", description: "A famous bard and Geralt's loyal friend, known for his songs and humor.", imageUrl: "https://i.postimg.cc/JhcjVNR2/Dandelion-1.jpg"),
            HeroModel1(id: UUID().uuidString, game: "The Witcher", name: "Emhyr", description: "The Emperor of Nilfgaard, a ruthless ruler and Ciri's father.", imageUrl: "https://i.postimg.cc/DZ22kWT9/Emhyr.png"),
            HeroModel1(id: UUID().uuidString, game: "The Witcher", name: "Lambert", description: "A sarcastic witcher from Kaer Morhen and ally of Geralt.", imageUrl: "https://i.postimg.cc/Wpftc7HT/Lambert.jpg"),
            HeroModel1(id: UUID().uuidString, game: "The Witcher", name: "Eskel", description: "A calm and loyal witcher, one of Geralt’s closest friends.", imageUrl: "https://i.postimg.cc/0j2szhXr/Eskel.jpg"),
            HeroModel1(id: UUID().uuidString, game: "The Witcher", name: "Keira Metz", description: "A cunning sorceress with her own ambitions, occasional ally to Geralt.", imageUrl: "https://i.postimg.cc/25RFCY3d/Keira-Metz.png"),
            
            // Mortal Kombat
            HeroModel1(id: UUID().uuidString, game: "Mortal Kombat", name: "Scorpion", description: "Legendary ninja and vengeful specter, master of hellfire.", imageUrl: "https://i.postimg.cc/c4Kn6Jgq/Scorpion.png"),
            HeroModel1(id: UUID().uuidString, game: "Mortal Kombat", name: "Sub-Zero", description: "Master of ice magic and loyal warrior of the Lin Kuei clan.", imageUrl: "https://i.postimg.cc/yNc7JMBy/Sub-Zero.png"),
            HeroModel1(id: UUID().uuidString, game: "Mortal Kombat", name: "Raiden", description: "God of Thunder and protector of Earthrealm.", imageUrl: "https://i.postimg.cc/6pzkbjmV/raiden1.jpg"),
            HeroModel1(id: UUID().uuidString, game: "Mortal Kombat", name: "Liu Kang", description: "Earthrealm’s champion and skilled martial artist with dragon spirit.", imageUrl: "https://i.postimg.cc/m2WZ42s2/Liu-Kang.png"),
            HeroModel1(id: UUID().uuidString, game: "Mortal Kombat", name: "Sonya Blade", description: "Elite soldier fighting against threats from other realms.", imageUrl: "https://i.postimg.cc/rsqNvRqR/Sonya-Blade.jpg"),
            HeroModel1(id: UUID().uuidString, game: "Mortal Kombat", name: "Johnny Cage", description: "A movie star and fierce fighter known for his bravado.", imageUrl: "https://i.postimg.cc/fyFjk2xm/Johnny-Cage.png"),
            HeroModel1(id: UUID().uuidString, game: "Mortal Kombat", name: "Kitana", description: "Princess of Edenia, master of steel fans and a fighter for justice.", imageUrl: "https://i.postimg.cc/fyLy1MSf/Kitana.jpg")
        ]

        let db = Firestore.firestore()

        for hero in heroes {
            let data: [String: Any] = [
                "id": hero.id,
                "name": hero.name,
                "description": hero.description,
                "imageUrl": hero.imageUrl,
                "game": hero.game
            ]

            db.collection("heroes").document(hero.id).setData(data) { error in
                if let error = error {
                    print("Error uploading hero: \(error.localizedDescription)")
                } else {
                    print("Hero \(hero.name) uploaded successfully!")
                }
            }
        }
    }
}

// MARK: - Hero Model

struct HeroModel1: Identifiable, Codable {
    var id: String
    var game: String
    var name: String
    var description: String
    var imageUrl: String
}
