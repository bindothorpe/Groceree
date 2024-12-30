//
//  ProfileViewModel.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
   @Published var userId: String?
   @Published var user: User?
   @Published var selectedTab = 0 // 0 for My Recipes, 1 for My Likes
   
   @Published var recipeListItems: [RecipeListItem] = []
   @Published var likedRecipes: [RecipeListItem] = []
   
   @Published var isLoading = false
   @Published var error: String?
   
   @Published var isLoadingRecipes = false
   @Published var errorRecipes: String?
   
   @Published var isLoadingLikes = false
   @Published var errorLikes: String?
   
   private let userRepository: UserRepositoryProtocol
   private let recipeRepository: RecipeRepositoryProtocol
   
   init(
       userId: String? = nil,
       userRepository: UserRepositoryProtocol = ServiceContainer.shared.userRepository,
       recipeRepository: RecipeRepositoryProtocol = ServiceContainer.shared.recipeRepository
   ) {
       self.userId = userId
       self.userRepository = userRepository
       self.recipeRepository = recipeRepository
   }
       
   @MainActor
   func fetchUser() async {
       isLoading = true
       error = nil
       
       do {
           if let userId {
               user = try await userRepository.fetchUser(id: userId)
           } else {
               user = try await userRepository.fetchCurrentUser()
           }
       } catch {
           self.error = error.localizedDescription
       }
       
       isLoading = false
   }
   
   @MainActor
   func fetchRecipes() async {
       isLoadingRecipes = true
       errorRecipes = nil
       
       do {
           if let userId {
               recipeListItems = try await recipeRepository.fetchRecipesFromUser(id: userId)
           } else {
               recipeListItems = try await recipeRepository.fetchRecipesFromCurrentUser()
           }
       } catch {
           self.errorRecipes = error.localizedDescription
       }
       
       isLoadingRecipes = false
   }
   
   @MainActor
   func fetchLikedRecipes() async {
       isLoadingLikes = true
       errorLikes = nil
       
       do {
           if let userId {
               likedRecipes = try await recipeRepository.fetchRecipesLikedByUser(id: userId)
           } else {
               likedRecipes = try await recipeRepository.fetchRecipesLikedByCurrentUser()
           }
       } catch {
           self.errorLikes = error.localizedDescription
       }
       
       isLoadingLikes = false
   }
   
   @MainActor
   func toggleFavorite(_ recipeListItem: RecipeListItem) {
       Task {
           do {
               try await recipeRepository.toggleFavorite(id: recipeListItem.id)
               
               // Create a new recipe item with toggled favorite status
               var updatedRecipe = recipeListItem
               updatedRecipe.isFavorite.toggle()
               
               // Update recipe in My Recipes list if present
               if let index = recipeListItems.firstIndex(where: { $0.id == recipeListItem.id }) {
                   recipeListItems[index].isFavorite = updatedRecipe.isFavorite
               }
               
               // Update liked recipes list based on new favorite status
               if updatedRecipe.isFavorite {
                   // If it's now favorited and not in liked list, add it
                   if !likedRecipes.contains(where: { $0.id == recipeListItem.id }) {
                       likedRecipes.append(updatedRecipe)
                   }
               } else {
                   // If it's now unfavorited, remove it from liked list
                   likedRecipes.removeAll { $0.id == recipeListItem.id }
               }
               
           } catch {
               if selectedTab == 0 {
                   errorRecipes = error.localizedDescription
               } else {
                   errorLikes = error.localizedDescription
               }
           }
       }
   }
}
