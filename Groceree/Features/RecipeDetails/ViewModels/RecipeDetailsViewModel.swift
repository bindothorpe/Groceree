//
//  RecipeViewModel.swift
//  Groceree
//
//  Created by Bindo Thorpe on 13/12/2024.
//

import SwiftUI

class RecipeDetailViewModel: ObservableObject {
    @Published var recipeId: String
    @Published var recipe: Recipe?
    @Published var showingActionSheet = false
    @Published var showingServingsSheet = false
    @Published var selectedServings: Int
    @Published var isLoading = false
    @Published var error: String?
    @Published var showingSuccessMessage = false
    
    private let recipeRepository: RecipeRepositoryProtocol
    private let shoppingListRepository: ShoppingListRepositoryProtocol
    
    init(
        recipeId: String,
        recipeRepository: RecipeRepositoryProtocol = ServiceContainer.shared.recipeRepository,
        shoppingListRepository: ShoppingListRepositoryProtocol = ServiceContainer.shared.shoppingListRepository
    ) {
        self.recipeId = recipeId
        self.recipeRepository = recipeRepository
        self.shoppingListRepository = shoppingListRepository
        self.selectedServings = 2 // Default value until recipe is loaded
        
        Task {
            await fetchRecipe()
        }
    }
    
    @MainActor
    func fetchRecipe() async {
        isLoading = true
        error = nil
        
        do {
            recipe = try await recipeRepository.fetchRecipe(id: recipeId)
            if let recipe {
                selectedServings = recipe.servings
            }
        } catch {
            self.error = error.localizedDescription
        }
        
        isLoading = false
    }
    
    @MainActor
    func toggleFavorite() {
        Task {
            do {
                try await recipeRepository.toggleFavorite(id: recipeId)
                if recipe != nil {
                    recipe?.isFavorite.toggle()
                }
            } catch {
                self.error = error.localizedDescription
            }
        }
    }
    
    func addToShoppingList() {
        showingServingsSheet = false
        
        if let recipe = recipe {
            shoppingListRepository.addRecipeIngredients(recipe: recipe, servings: selectedServings)
            showingSuccessMessage = true
            
            // Hide success message after 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.showingSuccessMessage = false
            }
        }
    }
    
    func addToBookmarks() {
        // TODO: Implement bookmark functionality
    }
    
    func addToFolder() {
        // TODO: Implement folder functionality
    }
    
    func editRecipe() {
        // TODO: Implement edit functionality
    }
}
