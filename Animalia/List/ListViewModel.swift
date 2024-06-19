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
        let animals = realm.objects(Animal.self).sorted(byKeyPath: "sortOrder", ascending: true)
        animalResult = animals.map { Animal(id: $0.id, type: $0.type, name: $0.name, isLocked: $0.isLocked, sortOrder: $0.sortOrder) }
        
        for animal in animalResult {
            print("Animal ID: \(animal.name), Sort Order: \(animal.sortOrder)")
        }
    }
    
    func deleteAnimal(by id: String, completion: @escaping (Bool) -> Void) {
        let realm = try! Realm()
        if let animalToDelete = realm.object(ofType: Animal.self, forPrimaryKey: id), !animalToDelete.isLocked {
            try! realm.write {
                realm.delete(animalToDelete)
                completion(true)
            }
        } else {
            completion(false)
        }
    } 
}
