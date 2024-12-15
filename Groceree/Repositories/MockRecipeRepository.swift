//
//  MockRecipeRepository.swift
//  Groceree
//
//  Created by Bindo Thorpe on 15/12/2024.
//

import Foundation

class MockRecipeRepository: RecipeRepositoryProtocol {
    private var recipes: [Recipe] = [
        Recipe(
            id: 1,
            author: Author(
                id: 1,
                firstName: "John",
                lastName: "Doe",
                imageUrl: "https://example.com/john.jpg"
            ),
            name: "Pasta Carbonara",
            imageUrl: "https://example.com/carbonara.jpg",
            duration: 30,
            servings: 2,
            ingredients: [
                Ingredient(id: 1, name: "Spaghetti", amount: 200, unit: .grams),
                Ingredient(id: 2, name: "Eggs", amount: 2, unit: .pieces),
                Ingredient(id: 3, name: "Parmesan", amount: 50, unit: .grams)
            ],
            instructions: [
                Instruction(id: 1, step: 1, instruction: "Cook pasta al dente"),
                Instruction(id: 2, step: 2, instruction: "Mix eggs and cheese"),
                Instruction(id: 3, step: 3, instruction: "Combine and serve hot")
            ],
            isFavorite: false
        ),
        Recipe(
            id: 2,
            author: Author(
                id: 1,
                firstName: "John",
                lastName: "Doe",
                imageUrl: "https://example.com/john.jpg"
            ),
            name: "Classic Burger",
            imageUrl: "https://example.com/burger.jpg",
            duration: 45,
            servings: 4,
            ingredients: [
                Ingredient(id: 4, name: "Ground Beef", amount: 500, unit: .grams),
                Ingredient(id: 5, name: "Buns", amount: 4, unit: .pieces),
                Ingredient(id: 6, name: "Lettuce", amount: 1, unit: .pieces)
            ],
            instructions: [
                Instruction(id: 4, step: 1, instruction: "Form beef into patties"),
                Instruction(id: 5, step: 2, instruction: "Grill until desired doneness"),
                Instruction(id: 6, step: 3, instruction: "Assemble with toppings")
            ],
            isFavorite: true
        )
    ]
    
    func fetchRecipeListItems() async throws -> [RecipeListItem] {
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        return recipes.map { recipe in
            RecipeListItem(
                id: recipe.id,
                name: recipe.name,
                imageUrl: recipe.imageUrl,
                duration: recipe.duration,
                isFavorite: recipe.isFavorite
            )
        }
    }
    
    func fetchRecipe(id: Int) async throws -> Recipe {
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        guard let recipe = recipes.first(where: { $0.id == id }) else {
            throw RecipeError.notFound
        }
        return recipe
    }
    
    func createRecipe(_ recipe: Recipe) async throws -> Recipe {
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        var newRecipe = recipe
        newRecipe.id = (recipes.map(\.id).max() ?? 0) + 1
        recipes.append(newRecipe)
        return newRecipe
    }
    
    func updateRecipe(_ recipe: Recipe) async throws -> Recipe {
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        guard let index = recipes.firstIndex(where: { $0.id == recipe.id }) else {
            throw RecipeError.notFound
        }
        recipes[index] = recipe
        return recipe
    }
    
    func deleteRecipe(id: Int) async throws {
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        recipes.removeAll { $0.id == id }
    }
    
    func toggleFavorite(id: Int) async throws {
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        guard let index = recipes.firstIndex(where: { $0.id == id }) else {
            throw RecipeError.notFound
        }
        recipes[index].isFavorite.toggle()
    }
    
    func addToShoppingList(recipeId: Int, servings: Int) async throws {
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        guard recipes.contains(where: { $0.id == recipeId }) else {
            throw RecipeError.notFound
        }
        print("Added recipe \(recipeId) to shopping list with \(servings) servings")
    }
}
