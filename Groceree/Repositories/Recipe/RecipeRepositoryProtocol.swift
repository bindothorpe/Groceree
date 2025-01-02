//
//  RecipeRepositoryProtocol.swift
//  Groceree
//
//  Created by Bindo Thorpe on 15/12/2024.
//

import Foundation
import UIKit

protocol RecipeRepositoryProtocol {
    
    // GET /api/recipes
    func fetchRecipeListItems() async throws -> [RecipeListItem]
    
    // GET /api/recipes/user/{user_id} where user_id is String
    func fetchRecipesFromUser(id: String) async throws -> [RecipeListItem]
    
    // GET /api/recipes/user/me
    func fetchRecipesFromCurrentUser() async throws -> [RecipeListItem]
    
    // GET /api/recipes/favorites/{user_id} where user_id is String
    func fetchRecipesLikedByUser(id: String) async throws -> [RecipeListItem]
    
    // GET /api/recipes/favorites/me
    func fetchRecipesLikedByCurrentUser() async throws -> [RecipeListItem]
    
    // GET /api/recipes/{recipe_id} where recipe_id is String
    func fetchRecipe(id: String) async throws -> Recipe
    
    // POST /api/recipes
    func createRecipe(_ recipe: CreateRecipeDTO) async throws -> RecipeListItem
    
    // PUT /api/recipes/{recipe_id} where recipe_id is String
    func updateRecipe(_ recipe: UpdateRecipeDTO) async throws -> RecipeListItem
    
    // TODO: Not implemented yet in the backend where recipe_id is String
    func deleteRecipe(id: String) async throws
    
    // POST /api/recipes/{recipe_id}/favorite where recipe_id is String
    func toggleFavorite(id: String) async throws
    
//    func addToShoppingList(recipeId: Int, servings: Int) async throws
    
    // POST /api/recipes/{recipe_id}/image where recipe_id is String
    func uploadImage(_ image: UIImage, for recipeId: String) async throws
}
