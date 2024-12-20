//
//  IngredientsSectionView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 15/12/2024.
//

import SwiftUI

struct IngredientsSectionView: View {
    @Binding var ingredients: [Ingredient]
    let onDelete: (Int) -> Void
    let onAdd: () -> Void
    
    var body: some View {
        Section("INGREDIENTEN") {
            ForEach($ingredients) { $ingredient in
                IngredientRowView(
                    ingredient: $ingredient,
                    onDelete: { onDelete(ingredient.id) }
                )
            }
            
            Button("Nieuw ingredient") {
                onAdd()
            }
            .foregroundColor(Theme.primary)
        }
    }
}
