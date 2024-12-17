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
                                showingServingsSheet: $viewModel.showingServingsSheet,
                                selectedServings: $viewModel.selectedServings,
                                onAddToShoppingList: viewModel.addToShoppingList
                            )
                            
                            RecipeInstructionsView(
                                instructions: recipe.instructions
                            )
                        }
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
                    Button("Toevoegen aan winkellijst", action: viewModel.addToShoppingList)
                    Button("Wijzig", action: viewModel.editRecipe)
                    Button("Cancel", role: .cancel) { }
                }
                .sheet(isPresented: $viewModel.showingServingsSheet) {
                    ServingsSheetView(
                        selectedServings: $viewModel.selectedServings,
                        isPresented: $viewModel.showingServingsSheet,
                        onConfirm: viewModel.addToShoppingList
                    )
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
