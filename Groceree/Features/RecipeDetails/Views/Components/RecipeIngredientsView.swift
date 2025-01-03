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
            Text("INGREDIENTS")
                .foregroundColor(.gray)
                .font(.system(size: 14))
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 16) {
                // Ingredients list
                ForEach(ingredients, id: \.self) { ingredient in
                    HStack(alignment: .center, spacing: 8) {
                        Text(ingredient.name)
                        Spacer()
                        Text("\(ingredient.amount)")
                            .foregroundColor(.gray)
                        Text(ingredient.unit.rawValue)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 4)
                }
                
                Divider()
                
                // Add to list section
                VStack(spacing: 0) {
                    if isAddingToList {
                        VStack(spacing: 16) {
                            // Stepper
                            Stepper(value: $selectedServings, in: 1...20) {
                                HStack {
                                    Text("Portion amount")
                                    Spacer()
                                    Text("\(selectedServings)")
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            // Action buttons
                            HStack(spacing: 0) {
                                Button(action: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        isAddingToList = false
                                    }
                                }) {
                                    Text("Cancel")
                                        .frame(maxWidth: .infinity)
                                        .foregroundColor(.gray)
                                }
                                .background(Color.white)
                                
                                Divider()
                                    .frame(height: 44)
                                
                                Button(action: {
                                    onAddToShoppingList()
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        isAddingToList = false
                                    }
                                }) {
                                    Text("Add")
                                        .frame(maxWidth: .infinity)
                                        .foregroundColor(Theme.primary)
                                }
                                .background(Color.white)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .transition(.asymmetric(
                            insertion: .scale(scale: 0.95).combined(with: .opacity),
                            removal: .scale(scale: 0.95).combined(with: .opacity)
                        ))
                    } else {
                        Button(action: {
                            selectedServings = defaultServings
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                isAddingToList = true
                            }
                        }) {
                            Text("Add to shopping list")
                                .foregroundColor(Theme.primary)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(8)
                        }
                        .transition(.asymmetric(
                            insertion: .scale(scale: 0.95).combined(with: .opacity),
                            removal: .scale(scale: 0.95).combined(with: .opacity)
                        ))
                    }
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
        }
    }
}
