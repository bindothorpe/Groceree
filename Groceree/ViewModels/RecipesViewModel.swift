//
//  RecipesViewModel.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//
import SwiftUI

class RecipesViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var searchResults: [Recipe] = []
    @Published var searchQuery: String = ""
    @Published var showingCreateRecipe = false

    
    var isSearching: Bool {
        !searchQuery.isEmpty
    }
    
    func fetchSearchResults() {
        searchResults = recipes.filter { recipe in
            recipe.name
                .lowercased()
                .contains(searchQuery.lowercased())
        }
    }
    
    func toggleFavorite(_ recipe: Recipe) {
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes[index].isFavorite.toggle()
        }
    }
    
    func fetchRecipes() {
        // Temporary sample data
        recipes = [
            Recipe(
                id: "1",
                name: "1Chili con carne",
                imageUrl: "https://example.com/chili.jpg",
                preparation: "Cook the meat...",
                duration: 90,
                portionAmount: 4,
                ingredientIds: ["1", "2", "3", "4", "5", "6"],
                isFavorite: false
            ),
            Recipe(
                id: "2",
                name: "2Pasta Carbonara",
                imageUrl: "https://example.com/pasta.jpg",
                preparation: "Boil pasta...",
                duration: 30,
                portionAmount: 2,
                ingredientIds: ["4", "5", "6"],
                isFavorite: false
            ),
            Recipe(
                id: "3",
                name: "3Chili con carne",
                imageUrl: "https://example.com/chili.jpg",
                preparation: "Cook the meat...",
                duration: 90,
                portionAmount: 4,
                ingredientIds: ["1", "2", "3"],
                isFavorite: false
            ),
            Recipe(
                id: "4",
                name: "4Pasta Carbonara",
                imageUrl: "https://example.com/pasta.jpg",
                preparation: "Boil pasta...",
                duration: 30,
                portionAmount: 2,
                ingredientIds: ["4", "5", "6"],
                isFavorite: false
            ),
            Recipe(
                id: "5",
                name: "5Chili con carne",
                imageUrl: "https://example.com/chili.jpg",
                preparation: "Cook the meat...",
                duration: 90,
                portionAmount: 4,
                ingredientIds: ["1", "2", "3"],
                isFavorite: false
            ),
            Recipe(
                id: "6",
                name: "6Pasta Carbonara",
                imageUrl: "https://example.com/pasta.jpg",
                preparation: "Boil pasta...",
                duration: 30,
                portionAmount: 2,
                ingredientIds: ["4", "5", "6"],
                isFavorite: false
            ),
            Recipe(
                id: "7",
                name: "7Pasta Carbonara",
                imageUrl: "https://example.com/pasta.jpg",
                preparation: "Boil pasta...",
                duration: 30,
                portionAmount: 2,
                ingredientIds: ["4", "5", "6"],
                isFavorite: false
            ),
            Recipe(
                id: "8",
                name: "8Pasta Carbonara",
                imageUrl: "https://example.com/pasta.jpg",
                preparation: "Boil pasta...",
                duration: 30,
                portionAmount: 2,
                ingredientIds: ["4", "5", "6"],
                isFavorite: false
            ),
            Recipe(
                id: "9",
                name: "9Pasta Carbonara",
                imageUrl: "https://example.com/pasta.jpg",
                preparation: "Boil pasta...",
                duration: 30,
                portionAmount: 2,
                ingredientIds: ["4", "5", "6"],
                isFavorite: false
            ),
        ]
    }
}
