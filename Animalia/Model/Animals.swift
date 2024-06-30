//
//  Animals.swift
//  Animalia
//
//  Created by Tiara H on 27/06/24.
//

import Foundation
import RealmSwift

class Animals: Object, AnimalContainer, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var type: String
    @Persisted var name: String
    @Persisted var isLocked: Bool
    @Persisted var sortOrder: Int
    @Persisted var hideName: Bool
    @Persisted var hideType: Bool
    
    override init() {
        super.init()
    }
    
    init(id: String = UUID().uuidString, type: String, name: String, isLocked: Bool = false, sortOrder: Int = 0, hideName: Bool = false, hideType: Bool = false) {
        super.init()
        self.id = id
        self.type = type
        self.name = name
        self.isLocked = isLocked
        self.sortOrder = sortOrder
        self.hideName = hideName
        self.hideType = hideType
    }
}
