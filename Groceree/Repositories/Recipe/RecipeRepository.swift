//
//  RecipeRepository.swift
//  Groceree
//
//  Created by Bindo Thorpe on 30/12/2024.
//

import Foundation
import UIKit

class RecipeRepository: RecipeRepositoryProtocol {
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
        let response: APIRecipeListResponse = try await apiClient.fetch(
            "/api/recipes/favorites/\(id)")
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
        let response: APICreateRecipeResponse = try await apiClient.fetch(
            "/api/recipes", method: "POST", body: recipe)
        return response.recipe.toRecipeListItem()
    }

    func updateRecipe(_ recipe: UpdateRecipeDTO) async throws -> RecipeListItem {
        let response: APIUpdateRecipeResponse = try await apiClient.fetch(
            "/api/recipes/\(recipe.id)", method: "PUT", body: recipe)
        return response.recipe.toRecipeListItem()
    }

    func deleteRecipe(id: String) async throws {
        let response: APIDeleteRecipeResponse = try await apiClient.fetch(
            "/api/recipes/\(id)", method: "DELETE")

        if response.error != nil {
            throw APIError.invalidRequest
        }
    }

    func toggleFavorite(id: String) async throws {
        let _: APIResponse = try await apiClient.fetch(
            "/api/recipes/\(id)/favorite", method: "post")
    }

    func uploadImage(_ image: UIImage, for recipeId: String) async throws {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw APIError.invalidRequest
        }

        guard imageData.count <= 5_242_880 else {
            throw APIError.invalidRequest
        }

        let boundary = UUID().uuidString

        guard let url = URL(string: "\(APIConstants.baseURL)/api/recipes/\(recipeId)/image") else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        if let token = try? KeychainManager.shared.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        request.setValue(
            "multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()

        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append(
            "Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(
                using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        request.httpBody = body

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.networkError(NSError(domain: "", code: -1))
            }

            switch httpResponse.statusCode {
            case 200...299:
                if let decodedResponse = try? JSONDecoder().decode(APIResponse.self, from: data) {
                    if decodedResponse.success == true {
                        return
                    }
                }
                throw APIError.serverError("Upload failed")

            case 400:
                throw APIError.invalidRequest
            case 401:
                throw APIError.unauthorized
            case 404:
                throw APIError.notFound
            default:
                if let errorResponse = try? JSONDecoder().decode(APIErrorResponse.self, from: data)
                {
                    throw APIError.serverError(errorResponse.error)
                }
                throw APIError.serverError(
                    "Upload failed with status code: \(httpResponse.statusCode)")
            }
        } catch {
            if let apiError = error as? APIError {
                throw apiError
            }
            throw APIError.networkError(error)
        }
    }

}
