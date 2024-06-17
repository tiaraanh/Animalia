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
    @StateObject var listViewModel = ListViewModel()
    @State private var showAnimalForm = false
    @State private var showSettings = false
    
    // MARK: - Body
    var body: some View {
        
        NavigationView {
            
            List {
                ForEach(listViewModel.animalResult, id: \.id) { animal in
                    NavigationLink(destination: DetailView(animal: animal as! Animal)) {
                        Text(animal.name)
                    }
                }
                .onDelete(perform: deleteItems)
                .onMove(perform: moveItems)
            }
            .navigationBarTitle("Animals List")
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
            listViewModel.getAnimals()
        }
        .onChange(of: showAnimalForm) { newValue in
            if !newValue {
                listViewModel.getAnimals()
            }
        }
    }
    
    // MARK: - Functions
    func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let animal = listViewModel.animalResult[index]
            listViewModel.deleteAnimal(by: animal.id)
        }
    }
    
    func moveItems(from source: IndexSet, to destination: Int) {
        
    }
}
