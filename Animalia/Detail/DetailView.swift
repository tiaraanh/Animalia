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
    @ObservedRealmObject var animal: Animals
    @StateObject private var viewModel = DetailViewModel()
    @Environment(\.presentationMode) var presentationMode
    @Binding var isActive: Bool
    var onDismiss: (() -> Void)?
    
    // MARK: - Body
    var body: some View {
        
        VStack() {
            
            content
            
            toggle
            
            actionButton
            
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

extension DetailView {
    
    // MARK: - Content
    private var content: some View {
        
        VStack(alignment: .leading) {
            Group {
                Text("Type")
                    .font(.system(size: 14, weight: .bold))
                
                TextField("Enter type", text: $animal.type)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 10)
                    .disabled(animal.isLocked)
            }
            
            Group {
                Text("Name")
                    .font(.system(size: 14, weight: .bold))
                
                TextField("Enter name", text: $animal.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 10)
                    .disabled(animal.isLocked)
            }
        }
    }
    
    // MARK: - Toggle
    private var toggle: some View {
        
        VStack {
            Toggle("Lock", isOn: $animal.isLocked)
                .padding(.top, 10)
                .onChange(of: animal.isLocked) { newValue in
                    viewModel.toggleLock(animal: animal) { success in
                        if success {
                            print("Toggle success")
                        } else {
                            print("Toggle failed")
                        }
                    }
                }
        }
    }
    
    // MARK: - Action Button
    private var actionButton: some View {
        
        VStack {
            Button(action: {
                viewModel.saveAnimal(animal: animal)
                isActive = false
                presentationMode.wrappedValue.dismiss()
                onDismiss?()
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
                viewModel.saveAndShareAsImage(image: content.asImage())
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
                viewModel.deleteAnimal(by: animal.id)
                presentationMode.wrappedValue.dismiss()
                onDismiss?()
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
        }
    }
}
