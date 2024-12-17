//
//  RecipesViewModel.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//
import SwiftUI

class RecipesViewModel: ObservableObject {
    @Published var recipeListItems: [RecipeListItem] = []
    @Published var searchQuery = ""
    @Published var showingCreateRecipe = false
    @Published var isLoading = false
    @Published var error: String?
    
    private let repository: RecipeRepositoryProtocol
    
    var searchResults: [RecipeListItem] {
        guard !searchQuery.isEmpty else { return recipeListItems }
        return recipeListItems.filter { recipe in
            recipe.name.lowercased().contains(searchQuery.lowercased())
        }
    }
    
    var isSearching: Bool {
        !searchQuery.isEmpty
    }
    
    init(repository: RecipeRepositoryProtocol = ServiceContainer.shared.recipeRepository) {
        self.repository = repository
    }
    
    @MainActor
    func fetchRecipes() async {
        isLoading = true
        error = nil
        
        Task {
            do {
                recipeListItems = try await repository.fetchRecipeListItems()
            } catch {
                self.error = error.localizedDescription
            }
            isLoading = false
        }
    }
    
    @MainActor
    func toggleFavorite(_ recipeListItem: RecipeListItem) {
        Task {
            do {
                try await repository.toggleFavorite(id: recipeListItem.id)
                if let index = recipeListItems.firstIndex(where: { $0.id == recipeListItem.id }) {
                    recipeListItems[index].isFavorite.toggle()
                }
            } catch {
                self.error = error.localizedDescription
            }
        }
    }
}
