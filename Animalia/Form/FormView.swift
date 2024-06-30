//
//  FormView.swift
//  Animalia
//
//  Created by Tiara H on 16/06/24.
//

import Foundation
import SwiftUI
import RealmSwift

struct FormView: View {
    
    // MARK: - Properties
    @Environment(\.presentationMode) var presentationMode
    @ObservedResults(Animals.self) var animals
    @StateObject var listViewModel = ListViewModel()
    
    @State private var type: String = ""
    @State private var name: String = ""
    @State private var animalId: String?
    
    // MARK: - Body
    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("Animal Details")) {
                    TextField("Type", text: $type)
                    TextField("Name", text: $name)
                }
            }
            .navigationBarTitle("Add Animal", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                addItem()
                listViewModel.getAnimals()
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    // MARK: - Function
    func addItem() {
        let newAnimal = Animals(type: type, name: name)
        $animals.append(newAnimal)
    }
}
