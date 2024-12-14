//
//  CreateRecipeView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 02/12/2024.
//

import SwiftUI

struct CreateRecipeView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = CreateRecipeViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                // ALGEMEEN section
                Section("ALGEMEEN") {
                    TextField("Naam", text: $viewModel.name)
                        .onChange(of: viewModel.name) {
                            if viewModel.name.count > 75 {
                                viewModel.name = String(viewModel.name.prefix(75))
                            }
                        }
                    
                    Button(action: {
                        // Add photo action
                    }) {
                        HStack {
                            Text("Foto")
                            Spacer()
                            Text("Voeg toe")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    DatePicker(
                        "Duratie",
                        selection: Binding(
                            get: {
                                Calendar.current.date(from: DateComponents(hour: viewModel.hours, minute: viewModel.minutes)) ?? Date()
                            },
                            set: { newDate in
                                let components = Calendar.current.dateComponents([.hour, .minute], from: newDate)
                                viewModel.hours = components.hour ?? 0
                                viewModel.minutes = components.minute ?? 0
                            }
                        ),
                        displayedComponents: .hourAndMinute
                    )
                    
                    HStack {
                        Text("Porties")
                        Spacer()
                        Stepper(
                            value: $viewModel.portions,
                            in: 1...20,
                            label: {
                                Text("\(viewModel.portions)")
                                    .foregroundColor(.gray)
                            }
                        )
                    }
                    
                    NavigationLink(destination: Text("Folder Selection View")) {
                        HStack {
                            Text("Folder")
                            Spacer()
                            Text("Kies")
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                // INGREDIENTEN section
                Section("INGREDIENTEN") {
                    //TODO: Make this work with the new models
//                    ForEach($viewModel.ingredients) { $ingredient in
//                        HStack {
//                            TextField("Ingredient", text: $ingredient.name)
//                            TextField("Amount", text: $ingredient.amount)
//                                .frame(width: 100)
//                        }
//                    }
//                    .onDelete { indexSet in
//                        viewModel.ingredients.remove(atOffsets: indexSet)
//                    }
                    
                    Button("Nieuw ingredient") {
                        viewModel.addIngredient()
                    }
                    .foregroundColor(Theme.primary)
                }
                
                // BEREIDING section
                Section("BEREIDING") {
                    TextEditor(text: $viewModel.preparation)
                        .frame(minHeight: 100)
                }
            }
            .navigationTitle("Nieuw recept")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Annuleer") {
                        dismiss()
                    }
                    .foregroundColor(Theme.primary)
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button("Maak recept") {
                        viewModel.createRecipe()
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isValid ? Theme.primary : Color.gray)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .disabled(!viewModel.isValid)
                }
            }
        }
    }
}
