//
//  IngredientsSectionView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 15/12/2024.
//

import SwiftUI

struct IngredientsSectionView: View {
    @Binding var ingredients: [Ingredient]
    let onDelete: (String) -> Void
    let onAdd: () -> Void
    
    var body: some View {
        Section("INGREDIENTS") {
            ForEach($ingredients) { $ingredient in
                IngredientRowView(
                    ingredient: $ingredient,
                    onDelete: { onDelete(ingredient.id) }
                )
            }
            
            Button("Add ingredient") {
                onAdd()
            }
            .foregroundColor(Theme.primary)
        }
    }
}
