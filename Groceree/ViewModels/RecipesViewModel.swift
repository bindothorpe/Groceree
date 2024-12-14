//
//  RecipesViewModel.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//
import SwiftUI

class RecipesViewModel: ObservableObject {
    @Published var recipeListItems: [RecipeListItem] = []
    @Published var searchResults: [RecipeListItem] = []
    @Published var searchQuery: String = ""
    @Published var showingCreateRecipe = false
    
    var isSearching: Bool {
        !searchQuery.isEmpty
    }
    
    func fetchSearchResults() {
        searchResults = recipeListItems.filter { recipe in
            recipe.name
                .lowercased()
                .contains(searchQuery.lowercased())
        }
    }
    
    func toggleFavorite(_ recipe: RecipeListItem) {
        if let index = recipeListItems.firstIndex(where: { $0.id == recipe.id }) {
            recipeListItems[index].isFavorite.toggle()
        }
    }
    
    func fetchRecipes() {
        // Temporary sample data
        recipeListItems = [
            RecipeListItem(
                id: 1,
                name: "Chili con carne",
                imageUrl: "https://example.com/chili.jpg",
                duration: 90,
                isFavorite: false
            ),
            RecipeListItem(
                id: 2,
                name: "Pasta Carbonara",
                imageUrl: "https://example.com/pasta.jpg",
                duration: 30,
                isFavorite: false
            ),
            RecipeListItem(
                id: 3,
                name: "Spaghetti Bolognese",
                imageUrl: "https://example.com/bolognese.jpg",
                duration: 45,
                isFavorite: false
            ),
            RecipeListItem(
                id: 4,
                name: "Caesar Salad",
                imageUrl: "https://example.com/caesar.jpg",
                duration: 15,
                isFavorite: false
            ),
            RecipeListItem(
                id: 5,
                name: "Chicken Curry",
                imageUrl: "https://example.com/curry.jpg",
                duration: 60,
                isFavorite: false
            )
        ]
    }
}
