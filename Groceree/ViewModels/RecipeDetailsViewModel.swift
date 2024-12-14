//
//  RecipeViewModel.swift
//  Groceree
//
//  Created by Bindo Thorpe on 13/12/2024.
//

import SwiftUI

class RecipeDetailViewModel: ObservableObject {
    @Published private(set) var recipe: Recipe? = nil
    @Published var showingActionSheet = false
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private var api: GrocereeAPIProtocol?
    private let recipeId: Int
    
    init(recipeId: Int) {
        self.recipeId = recipeId
    }
    
    func setAPI(_ api: GrocereeAPIProtocol) {
        self.api = api
    }
    
    // MARK: - Data Fetching
    func fetchRecipe() {
        isLoading = true
        
        Task {
            do {
                let response = try await api.fetchRecipe(id: recipeId)
                await MainActor.run {
                    if response.isSuccess {
                        self.recipe = Recipe.from(apiModel: response.data)
                        self.errorMessage = nil
                    } else {
                        self.errorMessage = response.message
                    }
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
    
    var formattedDuration: String {
        guard let recipe = recipe else { return "" }
        
        let hours = recipe.duration / 60
        let minutes = recipe.duration % 60
        
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else {
            return "\(minutes)m"
        }
    }
    
    // MARK: - Actions
    func toggleFavorite() {
    }
    
    func addToBookmarks() {
//        Task {
//            do {
//                let response = try await api.addToBookmarks(recipeId: recipeId)
//                await MainActor.run {
//                    if response.isSuccess {
//                        // Update local state if needed
//                        self.errorMessage = nil
//                    } else {
//                        self.errorMessage = response.message
//                    }
//                }
//            } catch {
//                await MainActor.run {
//                    self.errorMessage = error.localizedDescription
//                }
//            }
//        }
    }
    
    func addToShoppingList() {
    }
    
    func addToFolder() {
    }
    
    func editRecipe() {
    }
}
