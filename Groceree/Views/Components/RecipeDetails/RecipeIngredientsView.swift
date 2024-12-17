//
//  RecipeIngredientsView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 15/12/2024.
//

import SwiftUI

struct RecipeIngredientsView: View {
    let ingredients: [Ingredient]
    let defaultServings: Int
    @Binding var selectedServings: Int
    @State private var isAddingToList = false
    let onAddToShoppingList: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("INGREDIENTEN")
                .foregroundColor(.gray)
                .font(.system(size: 14))
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 16) {
                ForEach(ingredients, id: \.self) { ingredient in
                    HStack(alignment: .center, spacing: 8) {
                        Text(ingredient.name)
                        Spacer()
                        Text("\(ingredient.amount)").foregroundColor(.gray)
                        Text(ingredient.unit.rawValue).foregroundColor(.gray)
                    }
                    .padding(.vertical, 4)
                }
                
                Divider()
                
                if isAddingToList {
                    // Expanded view with serving selection
                    VStack(spacing: 16) {
                        Stepper(
                            value: $selectedServings,
                            in: 1...20
                        ) {
                            HStack {
                                Text("Aantal porties")
                                Spacer()
                                Text("\(selectedServings)")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        HStack(spacing: 0) {
                            Button(action: {
                                isAddingToList = false
                            }) {
                                Text("Annuleer")
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity)
                            }
                            
                            Divider()
                                .frame(height: 20)
                            
                            Button(action: {
                                onAddToShoppingList()
                                isAddingToList = false
                            }) {
                                Text("Toevoegen")
                                    .foregroundColor(Theme.primary)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                    }
                } else {
                    // Collapsed view with just the button
                    Button(action: {
                        selectedServings = defaultServings // Reset to default
                        isAddingToList = true
                    }) {
                        Text("Toevoegen aan winkellijstje")
                            .foregroundColor(Theme.primary)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
                    .shadow(radius: 4)
            )
            .padding(.horizontal)
            .animation(.spring(), value: isAddingToList)
        }
    }
}
