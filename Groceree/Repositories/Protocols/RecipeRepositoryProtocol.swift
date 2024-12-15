//
//  RecipeRepositoryProtocol.swift
//  Groceree
//
//  Created by Bindo Thorpe on 15/12/2024.
//

import Foundation

protocol RecipeRepositoryProtocol {
    func fetchRecipeListItems() async throws -> [RecipeListItem]
    func fetchRecipe(id: Int) async throws -> Recipe
    func createRecipe(_ recipe: Recipe) async throws -> Recipe
    func updateRecipe(_ recipe: Recipe) async throws -> Recipe
    func deleteRecipe(id: Int) async throws
    func toggleFavorite(id: Int) async throws
    func addToShoppingList(recipeId: Int, servings: Int) async throws
}
