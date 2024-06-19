//
//  AnimalContainer.swift
//  Animalia
//
//  Created by Tiara H on 17/06/24.
//

import Foundation

protocol AnimalContainer {
    
    var id: String { get }
    var type: String { get set }
    var name: String { get set }
    var isLocked: Bool { get set }
    var sortOrder: Int { get set }
}
