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
    
    init(
        recipeId: Int,
        repository: RecipeRepositoryProtocol = ServiceContainer.shared.recipeRepository
    ) {
        self.recipeId = recipeId
        self.repository = repository
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
    
    func addToShoppingList() {
        Task {
            do {
                try await repository.addToShoppingList(recipeId: recipeId, servings: selectedServings)
                // You might want to show a success message or handle the success case
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
