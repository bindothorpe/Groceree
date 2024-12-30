//
//  RecipeRepository.swift
//  Groceree
//
//  Created by Bindo Thorpe on 30/12/2024.
//

class RecipeRepository : RecipeRepositoryProtocol {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func fetchRecipeListItems() async throws -> [RecipeListItem] {
        let response: APIRecipeListResponse = try await apiClient.fetch("/api/recipes")
        return response.recipes.map { $0.toRecipeListItem() }
    }
    
    func fetchRecipesFromUser(id: String) async throws -> [RecipeListItem] {
        let response: APIRecipeListResponse = try await apiClient.fetch("/api/recipes/user/\(id)")
        return response.recipes.map { $0.toRecipeListItem() }
    }
    
    func fetchRecipesFromCurrentUser() async throws -> [RecipeListItem] {
        let response: APIRecipeListResponse = try await apiClient.fetch("/api/recipes/user/me")
        return response.recipes.map { $0.toRecipeListItem() }
        
    }
    
    func fetchRecipesLikedByUser(id: String) async throws -> [RecipeListItem] {
        let response: APIRecipeListResponse = try await apiClient.fetch("/api/recipes/favorites/\(id)")
        return response.recipes.map { $0.toRecipeListItem() }
    }
    
    func fetchRecipesLikedByCurrentUser() async throws -> [RecipeListItem] {
        let response: APIRecipeListResponse = try await apiClient.fetch("/api/recipes/favorites/me")
        return response.recipes.map { $0.toRecipeListItem() }
    }
    
    func fetchRecipe(id: String) async throws -> Recipe {
        let response: APIRecipeResponse = try await apiClient.fetch("/api/recipes/\(id)")
        return response.recipe.toRecipe()
    }
    
    func createRecipe(_ recipe: CreateRecipeDTO) async throws -> RecipeListItem {
        let response: APICreateRecipeResponse = try await apiClient.fetch("/api/recipes/", method: "post", body: recipe)
        return response.recipe.toRecipeListItem()
    }
    
    func updateRecipe(_ recipe: UpdateRecipeDTO) async throws -> RecipeListItem {
        let response: APIUpdateRecipeResponse = try await apiClient.fetch("/api/recipes/\(recipe.id)", method: "put", body: recipe)
        return response.recipe.toRecipeListItem()
    }
    
    func deleteRecipe(id: String) async throws {
        //TODO: Implement
    }
    
    func toggleFavorite(id: String) async throws {
        let _: APIResponse = try await apiClient.fetch("/api/recipes/\(id)/favorite", method: "post")
    }
    
    
    
    
}
