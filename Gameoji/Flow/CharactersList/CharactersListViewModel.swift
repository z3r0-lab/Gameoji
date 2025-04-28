//
//  CharactersListViewModel.swift
//  Gameoji
//
//  Created by Бағжан Артыкбаев on 27.04.2025.
//

import Foundation
import FirebaseFirestore

class CharactersListViewModel: ObservableObject {
    @Published var heroes: [HeroModel] = []
    @Published var isLoading = false
    
    private var db = Firestore.firestore()
    
    func fetchUser(forGame game: String) {
        isLoading = true
        db.collection("heroes")
            .whereField("game", isEqualTo: game)
            .getDocuments { snap, err in
                if let err = err {
                    print("Error fetching heroes: \(err.localizedDescription)")
                    self.isLoading = false
                    return
                }
                
                self.heroes = snap?.documents.compactMap { doc -> HeroModel? in
                    let data = doc.data()
                    
                    guard let id = data["id"] as? String,
                          let name = data["name"] as? String,
                          let description = data["description"] as? String,
                          let imageUrl = data["imageUrl"] as? String,
                          let game = data["game"] as? String else {
                        return nil
                    }
                    
                    return HeroModel(id: id, name: name, description: description, imageUrl: imageUrl, game: game)
                } ?? []
                self.isLoading = false
            }
    }
}
