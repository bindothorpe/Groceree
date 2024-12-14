//
//  RecipeViewModel.swift
//  Groceree
//
//  Created by Bindo Thorpe on 13/12/2024.
//

import SwiftUI

class RecipeDetailViewModel: ObservableObject {
    @Published var recipeId: Int
    @Published var recipe: Recipe
    @Published var showingActionSheet = false
    @Published var showingServingsSheet = false
    @Published var selectedServings: Int
    
    init(recipeId: Int) {
        self.recipeId = recipeId
        //TODO: Here I would normally make an API call to fetch the recipe
        let recipe = Recipe(
            id: recipeId,
            author: Author(id: 1, firstName: "Jan", lastName: "Jansens", imageUrl: nil),
            name: "Carbonara",
            imageUrl: "https://example.url.png",
            duration: 30,
            servings: 2,
            ingredients: [
                Ingredient(id: 1, name: "Guancale", amount: 200, unit: .grams),
                Ingredient(id: 2, name: "Parmigiano", amount: 150, unit: .grams),
                Ingredient(id: 3, name: "Eggs", amount: 3, unit: .pieces),
                Ingredient(id: 4, name: "Spaghetti", amount: 300, unit: .grams),
                Ingredient(id: 5, name: "Water", amount: 500, unit: .milliliters)
            ],
            instructions: [
                Instruction(id: 1, step: 1, instruction: "Cook the pasta"),
                Instruction(id: 2, step: 2, instruction: "Put a cold pan on the stovetop and put the guancale in the cold pan, turn the heat to meadium"),
                Instruction(id: 3, step: 3, instruction: "Grate the cheese and mix it with the egg yolks")
            ],
            isFavorite: false
        )
        
        self.recipe = recipe
        self.selectedServings = recipe.servings
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
