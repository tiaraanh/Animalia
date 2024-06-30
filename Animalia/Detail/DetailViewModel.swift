//
//  DetailViewModel.swift
//  Animalia
//
//  Created by Tiara H on 17/06/24.
//

import Foundation
import RealmSwift
import SwiftUI

final class DetailViewModel: ObservableObject {
    
    func deleteAnimal(by id: String) {
        let realm = try! Realm()
        if let animalToDelete = realm.object(ofType: Animals.self, forPrimaryKey: id) {
            try! realm.write {
                realm.delete(animalToDelete)
            }
        }
    }
    
    func saveAnimal(animal: Animals) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(animal, update: .modified)
            print("Animal updated: \(animal)")
        }
    }
    
    func toggleLock(animal: Animals, completion: @escaping (Bool) -> Void) {
        do {
            let realm = try Realm()
            try realm.write {
                let copiedAnimal = realm.create(Animals.self, value: animal, update: .modified)
                copiedAnimal.isLocked.toggle()
                completion(true)
            }
        } catch {
            print("Error toggling lock: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func saveAndShareAsImage(image: UIImage) {
        let snapshotHelper = SnapshotHelper()
        snapshotHelper.share(image: image, from: UIApplication.shared.windows.first?.rootViewController)
    }
}
