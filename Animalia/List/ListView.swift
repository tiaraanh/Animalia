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
    }
    
    // MARK: - Functions
    func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let animal = viewModel.animalResult[index]
            viewModel.deleteAnimal(by: animal.id)
        }
    }
    
    func moveItems(from source: IndexSet, to destination: Int) {
        
    }
}
