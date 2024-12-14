//
//  RecipesViewModel.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//
import SwiftUI

class RecipesViewModel: ObservableObject {
    @Published var recipes: [RecipeListItem] = []
    @Published var searchQuery: String = ""
    @Published var showingCreateRecipe = false
    @Published var errorMessage: String?
    
    private let api: GrocereeAPIProtocol
    
    init(api: GrocereeAPIProtocol) {
        self.api = api
    }
    
    func fetchRecipes() {
        Task {
            do {
                let response = try await api.fetchRecipesList()
                await MainActor.run {
                    if response.isSuccess {
                        self.recipes = response.data.map {RecipeListItem.from(apiModel: $0)}
                        self.errorMessage = nil
                    } else {
                        self.errorMessage = response.message
                    }
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    // Will implement these later
    func searchRecipes() {
        // To be implemented
    }
    
    func toggleFavorite(_ recipe: APIRecipeListItem) {
        // To be implemented
    }
}
