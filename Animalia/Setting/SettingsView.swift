//
//  SettingsView.swift
//  Animalia
//
//  Created by Tiara H on 16/06/24.
//

import Foundation
import SwiftUI
import RealmSwift

struct SettingsView: View {
    
    // MARK: - Properties
    @ObservedResults(Animals.self) var animals
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: SettingsViewModel
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            Form {
                Toggle("Hide Name", isOn: Binding(
                    get: { animals.allSatisfy { $0.hideName } },
                    set: { newValue in
                        viewModel.toggleHideNameForAllAnimals(animals: Array(animals), hideName: newValue)
                        print("Toggled hideName for all animals: \(newValue)")
                    }
                ))
                Toggle("Hide Type", isOn: Binding(
                    get: { animals.allSatisfy { $0.hideType } },
                    set: { newValue in
                        viewModel.toggleHideTypeForAllAnimals(animals: Array(animals), hideType: newValue)
                        print("Toggled hideType for all animals: \(newValue)")
                    }
                ))
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    viewModel.saveAnimals(animals: Array(animals))
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}
