//
//  RecipeViewModel.swift
//  Groceree
//
//  Created by Bindo Thorpe on 13/12/2024.
//

import SwiftUI

class RecipeDetailViewModel: ObservableObject {
    @Published var recipeId: Int
    @Published var recipe: Recipe?
    @Published var showingActionSheet = false
    @Published var showingServingsSheet = false
    @Published var selectedServings: Int
    @Published var isLoading = false
    @Published var error: String?
    
    private let repository: RecipeRepositoryProtocol
        private let shoppingListRepository: ShoppingListRepositoryProtocol
        
        init(
            recipeId: Int,
            repository: RecipeRepositoryProtocol = ServiceContainer.shared.recipeRepository,
            shoppingListRepository: ShoppingListRepositoryProtocol = ServiceContainer.shared.shoppingListRepository
        ) {
            self.recipeId = recipeId
            self.repository = repository
            self.shoppingListRepository = shoppingListRepository
            self.selectedServings = 2
            
            Task {
                await fetchRecipe()
            }
        }
    
    @MainActor
    func fetchRecipe() async {
        isLoading = true
        error = nil
        
        do {
            recipe = try await repository.fetchRecipe(id: recipeId)
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
                try await repository.toggleFavorite(id: recipeId)
                if recipe != nil {
                    recipe?.isFavorite.toggle()
                }
            } catch {
                self.error = error.localizedDescription
            }
        }
    }
    
    @MainActor
        func addToShoppingList() {
            Task {
                do {
                    try await shoppingListRepository.addRecipeIngredients(
                        recipeId: recipeId,
                        servings: selectedServings
                    )
                } catch {
                    self.error = error.localizedDescription
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
