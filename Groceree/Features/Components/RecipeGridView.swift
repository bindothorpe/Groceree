//
//  RecipeGridView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 19/12/2024.
//

import SwiftUI

struct RecipeGridView: View {
    let recipeListItems: [RecipeListItem]
    let onFavoriteToggle: (RecipeListItem) -> Void
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(recipeListItems) { recipeListItem in
                RecipeCard(
                    recipeListItem: recipeListItem,
                    onFavoriteToggle: {
                        onFavoriteToggle(recipeListItem)
                    }
                ).frame(height: 280)
            }
        }
        .padding()
    }
}
