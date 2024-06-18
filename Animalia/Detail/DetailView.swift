//
//  DetailView.swift
//  Animalia
//
//  Created by Tiara H on 16/06/24.
//

import SwiftUI
import RealmSwift

struct DetailView: View {
    
    // MARK: - Properties
    @ObservedRealmObject var animal: Animal
    @StateObject private var viewModel = DetailViewModel()
    @Environment(\.presentationMode) var presentationMode
    @Binding var isActive: Bool
    var onDismiss: (() -> Void)?
    
    // MARK: - Body
    var body: some View {
        
        VStack(alignment: .leading) {
            Group {
                Text("Type")
                    .font(.system(size: 14, weight: .bold))
                
                TextField("Enter type", text: $animal.type)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 10)
            }
            
            Group {
                Text("Name")
                    .font(.system(size: 14, weight: .bold))
                
                TextField("Enter name", text: $animal.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 10)
            }
            
            Toggle("Lock", isOn: $animal.isLocked)
                .padding(.top, 10)
            
            Button(action: {
                viewModel.saveAnimal(animal: animal)
                isActive = false
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top, 10)
            
            Button(action: {
                
            }) {
                Text("Save as Image")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top, 10)
            
            Button(action: {
                
            }) {
                Text("Delete")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(animal.isLocked ? Color.gray : Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top, 10)
            .disabled(animal.isLocked)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Animal Detail")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            onDismiss?()
        }
    }
}