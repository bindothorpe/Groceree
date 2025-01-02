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
    @Published var showingDeleteConfirmation = false
    @Published var isDeletingRecipe = false
    @Published var deletionError: String?
    @Published private(set) var isCurrentUserAuthor: Bool = false
    @Published var showingEditRecipe = false
    
    private var currentUsername: String? {
        try? KeychainManager.shared.getUsername()
    }
    
    var canEditOrDelete: Bool {
        isCurrentUserAuthor
    }
    
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
                // Check if current user is the author
                isCurrentUserAuthor = currentUsername == recipe.author.id
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
    
    @MainActor
        func removeRecipe() async {
            isDeletingRecipe = true
            deletionError = nil
            
            do {
                try await recipeRepository.deleteRecipe(id: recipeId)
                isDeletingRecipe = false
                // Successfully deleted - navigation will be handled by the view
            } catch {
                isDeletingRecipe = false
                deletionError = "Failed to delete recipe: \(error.localizedDescription)"
                // Show error to user
                showingDeleteConfirmation = false
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
}
