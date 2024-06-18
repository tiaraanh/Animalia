//
//  ContentView.swift
//  Animalia
//
//  Created by Tiara H on 13/06/24.
//

import SwiftUI
import RealmSwift

struct ListView: View {
    
    // MARK: - Properties
    @ObservedResults(Animal.self) var animals
    @StateObject var viewModel = ListViewModel()
    @State private var showAnimalForm = false
    @State private var showSettings = false
    @State private var isDetailViewActive = false
    @State private var showAlert = false
    @State private var animalToDelete: AnimalContainer?
    
    // MARK: - Body
    var body: some View {
        
        NavigationView {
            
            List {
                ForEach(viewModel.animalResult, id: \.id) { animal in
                    NavigationLink(destination: DetailView(animal: animal as! Animal, isActive: $isDetailViewActive, onDismiss: {
                        viewModel.getAnimals()
                    })) {
                        Text(animal.name)
                    }
                }
                .onDelete(perform: deleteItems)
                .onMove(perform: moveItems)
            }
            .navigationBarTitle("Animal List")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                showAnimalForm = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
            .fullScreenCover(isPresented: $showAnimalForm) {
                FormView()
            }
        }
        .onAppear {
            viewModel.getAnimals()
        }
        .onChange(of: showAnimalForm) { newValue in
            if !newValue {
                viewModel.getAnimals()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Confirm Delete"),
                message: Text("Are you sure you want to delete this animal?"),
                primaryButton: .destructive(Text("Delete")) {
                    if let animal = animalToDelete {
                        viewModel.deleteAnimal(by: animal.id) { success in
                            if success {
                                DispatchQueue.main.async {
                                    viewModel.animalResult.removeAll { $0.id == animal.id }
                                }
                            }
                        }
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    // MARK: - Functions
    func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let animal = viewModel.animalResult[index]
            animalToDelete = animal
            showAlert = true
        }
    }
    
    func moveItems(from source: IndexSet, to destination: Int) {
        
    }
}
