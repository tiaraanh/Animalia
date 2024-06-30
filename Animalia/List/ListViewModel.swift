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
        let animals = realm.objects(Animals.self).sorted(byKeyPath: "sortOrder", ascending: true)
        
        animalResult = animals.filter { !$0.hideName && !$0.hideType }
            .map { Animals(id: $0.id, type: $0.type, name: $0.name, isLocked: $0.isLocked, sortOrder: $0.sortOrder, hideName: $0.hideName, hideType: $0.hideType) }
        
        for animal in animalResult {
            print("Animal ID: \(animal.name), Animal Type: \(animal.type), Sort Order: \(animal.sortOrder)")
        }
    }

    func deleteAnimal(by id: String, completion: @escaping (Bool) -> Void) {
        let realm = try! Realm()
        if let animalToDelete = realm.object(ofType: Animals.self, forPrimaryKey: id), !animalToDelete.isLocked {
            try! realm.write {
                realm.delete(animalToDelete)
                completion(true)
            }
        } else {
            completion(false)
        }
    } 
}
