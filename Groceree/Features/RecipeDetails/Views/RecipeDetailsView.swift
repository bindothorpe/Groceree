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
    
    init(recipeId: String) {
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
                .sheet(isPresented: $viewModel.showingEditRecipe) {
                    RecipeFormView(mode: .edit(viewModel.recipe!), onActionSuccess: {
                        Task {
                            await viewModel.fetchRecipe()
                            viewModel.showingEditRecipe = false
                        }
                    })
                }
                .confirmationDialog(
                    "Recipe Options",
                    isPresented: $viewModel.showingActionSheet
                ) {
                    Button("Mark as favorite", action: viewModel.toggleFavorite)
                    if viewModel.canEditOrDelete {
                        Button("Edit") {
                            viewModel.showingEditRecipe = true
                        }
                        Button("Delete", role: .destructive) {
                            viewModel.showingDeleteConfirmation = true
                        }
                    }
                    Button("Cancel", role: .cancel) { }
                }
                .confirmationDialog(
                    "Are you sure you want to delete this recipe",
                    isPresented: $viewModel.showingDeleteConfirmation,
                    titleVisibility: .visible
                ) {
                    Button("Delete", role: .destructive) {
                        Task {
                            await viewModel.removeRecipe()
                            if viewModel.deletionError == nil {
                                dismiss()
                            }
                        }
                    }
                    Button("Cancel", role: .cancel) { }
                }
                .alert(
                    "Error",
                    isPresented: .init(
                        get: { viewModel.deletionError != nil },
                        set: { if !$0 { viewModel.deletionError = nil } }
                    )
                ) {
                    Button("OK", role: .cancel) { }
                } message: {
                    if let error = viewModel.deletionError {
                        Text(error)
                    }
                }
                .overlay {
                    if viewModel.isDeletingRecipe {
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                            .overlay {
                                ProgressView()
                                    .tint(.white)
                                    .scaleEffect(1.5)
                            }
                    }
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
