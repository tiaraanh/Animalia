//
//  DetailViewModel.swift
//  Animalia
//
//  Created by Tiara H on 17/06/24.
//

import Foundation
import RealmSwift

final class DetailViewModel: ObservableObject {
    
    func deleteAnimal(by id: String) {
        let realm = try! Realm()
        if let animalToDelete = realm.object(ofType: Animal.self, forPrimaryKey: id) {
            try! realm.write {
                realm.delete(animalToDelete)
            }
        }
    }
    
    func saveAnimal(animal: Animal) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(animal, update: .modified)
            print("Animal updated: \(animal)")
        }
    }
}
