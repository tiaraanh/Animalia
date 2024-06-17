//
//  ListViewModel.swift
//  Animalia
//
//  Created by Tiara H on 17/06/24.
//

import Foundation
import RealmSwift

final class ListViewModel: ObservableObject {
    
    @Published var animalResult: [AnimalContainer] = []
    
    func getAnimals() {
        let realm = try! Realm()
        animalResult = realm.objects(Animal.self).map { Animal(id: $0.id, type: $0.type, name: $0.name, isLocked: $0.isLocked) }
    }
    
    func deleteAnimal(by id: String) {
        let realm = try! Realm()
        if let animalToDelete = realm.object(ofType: Animal.self, forPrimaryKey: id) {
            try! realm.write {
                realm.delete(animalToDelete)
            }
        }
    }
}
