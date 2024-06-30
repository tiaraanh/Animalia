//
//  SettingsViewModel.swift
//  Animalia
//
//  Created by Tiara H on 27/06/24.
//

import Foundation
import RealmSwift

final class SettingsViewModel: ObservableObject {
    
    func toggleHideNameForAllAnimals(animals: [Animals], hideName: Bool) {
        let realm = try! Realm()
        try! realm.write {
            for animal in animals {
                let managedAnimal = realm.object(ofType: Animals.self, forPrimaryKey: animal.id)
                managedAnimal?.hideName = hideName
            }
        }
    }
    
    func toggleHideTypeForAllAnimals(animals: [Animals], hideType: Bool) {
        let realm = try! Realm()
        try! realm.write {
            for animal in animals {
                let managedAnimal = realm.object(ofType: Animals.self, forPrimaryKey: animal.id)
                managedAnimal?.hideType = hideType
            }
        }
    }
    
    func saveAnimals(animals: [Animals]) {
        let realm = try! Realm()
        try! realm.write {
            for animal in animals {
                let managedAnimal = realm.object(ofType: Animals.self, forPrimaryKey: animal.id)
                managedAnimal?.hideName = animal.hideName
                managedAnimal?.hideType = animal.hideType
            }
        }
    }
}
