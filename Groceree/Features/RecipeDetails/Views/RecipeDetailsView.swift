//
//  RecipeDetailView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 13/12/2024.
//

import SwiftUI

struct RecipeDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: RecipeDetailViewModel
    
    init(recipeId: Int) {
        _viewModel = StateObject(wrappedValue: RecipeDetailViewModel(recipeId: recipeId))
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else if let recipe = viewModel.recipe {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        RecipeHeaderView(
                            imageUrl: recipe.imageUrl,
                            authorId: recipe.author.id,
                            authorFirstName: recipe.author.firstName
                        )
                        
                        VStack(alignment: .leading, spacing: 40) {
                            RecipeGeneralInfoView(
                                servings: recipe.servings,
                                duration: recipe.formattedDuration()
                            )
                            
                            RecipeIngredientsView(
                                ingredients: recipe.ingredients,
                                defaultServings: recipe.servings,
                                selectedServings: $viewModel.selectedServings,
                                onAddToShoppingList: viewModel.addToShoppingList
                            )
                            
                            RecipeInstructionsView(
                                instructions: recipe.instructions
                            )
                        }
                    }
                }
                .overlay(alignment: .bottom) {
                    if viewModel.showingSuccessMessage {
                        Text("Added to shopping list")
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(Theme.primary)
                            .clipShape(Capsule())
                            .padding(.bottom, 32)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .animation(.spring(), value: viewModel.showingSuccessMessage)
                    }
                }
                .navigationBarTitleDisplayMode(.large)
                .navigationTitle(recipe.name)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack(spacing: 8) {
                            Button(action: viewModel.toggleFavorite) {
                                Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                                    .foregroundColor(Theme.primary)
                            }
                            
                            Button(action: { viewModel.showingActionSheet = true }) {
                                Image(systemName: "ellipsis")
                                    .foregroundColor(Theme.primary)
                            }
                        }
                    }
                }
                .confirmationDialog(
                    "Recipe Options",
                    isPresented: $viewModel.showingActionSheet
                ) {
                    Button("Markeer als favoriet", action: viewModel.toggleFavorite)
                    Button("Recept bewaren", action: viewModel.addToBookmarks)
                    Button("Toevoegen aan folder", action: viewModel.addToFolder)
                    Button("Wijzig", action: viewModel.editRecipe)
                    Button("Cancel", role: .cancel) { }
                }
            } else if let error = viewModel.error {
                ContentUnavailableView(
                    "Error",
                    systemImage: "exclamationmark.triangle",
                    description: Text(error)
                )
            } else {
                ContentUnavailableView(
                    "Recipe not found",
                    systemImage: "questionmark.circle"
                )
            }
        }
    }
}
