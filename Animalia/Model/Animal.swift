//
//  Animal.swift
//  Animalia
//
//  Created by Tiara H on 16/06/24.
//

import Foundation
import RealmSwift

class Animal: Object, AnimalContainer, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var type: String
    @Persisted var name: String
    @Persisted var isLocked: Bool
    
    override init() {
        super.init()
    }
    
    init(id: String = UUID().uuidString, type: String, name: String, isLocked: Bool = false) {
        super.init()
        self.id = id
        self.type = type
        self.name = name
        self.isLocked = isLocked
    }
}
