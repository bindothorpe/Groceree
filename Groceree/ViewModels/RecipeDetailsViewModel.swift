//
//  RecipeViewModel.swift
//  Groceree
//
//  Created by Bindo Thorpe on 13/12/2024.
//

import SwiftUI

class RecipeDetailViewModel: ObservableObject {
    @Published var recipe: Recipe
    @Published var showingActionSheet = false
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    var formattedDuration: String {
        let hours = recipe.duration / 60
        let minutes = recipe.duration % 60
        
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else {
            return "\(minutes)m"
        }
    }
    
    func toggleFavorite() {
        recipe.isFavorite.toggle()
        // TODO: Update in database
    }
    
    func addToBookmarks() {
        // TODO: Implement bookmark functionality
    }
    
    func addToShoppingList() {
        // TODO: Implement shopping list functionality
    }
    
    func addToFolder() {
        // TODO: Implement folder functionality
    }
    
    func editRecipe() {
        // TODO: Implement edit functionality
    }
}
