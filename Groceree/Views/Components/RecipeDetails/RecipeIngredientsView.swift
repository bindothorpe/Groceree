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
    @Binding var showingServingsSheet: Bool
    @Binding var selectedServings: Int
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
                        Text(ingredient.unit.displayName).foregroundColor(.gray)
                    }
                    .padding(.vertical, 4)
                }
                
                Divider()
                
                Button(action: {
                    selectedServings = defaultServings // Reset to default
                    showingServingsSheet = true
                }) {
                    Text("Toevoegen aan winkellijstje")
                        .foregroundColor(Theme.primary)
                }
                .frame(maxWidth: .infinity, alignment: .center)
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
