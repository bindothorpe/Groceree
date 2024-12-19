//
//  ProfileView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel: ProfileViewModel
    
    init(userId: String) {
        _viewModel = StateObject(wrappedValue: ProfileViewModel(userId: userId))
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else if let user = viewModel.user {
                NavigationStack {
                    ScrollView {
                        VStack(spacing: 24) {
                            ProfileInfoView(user: user)
                            
                            // Recipes Section
                            VStack(alignment: .leading, spacing: 16) {
                                // Tab selector
                                Picker("", selection: $viewModel.selectedTab) {
                                    Text("My Recipes").tag(0)
                                    Text("My Likes").tag(1)
                                }
                                .pickerStyle(.segmented)
                                .padding(.horizontal)
                                
                                // Content based on selected tab
                                if viewModel.selectedTab == 0 {
                                    // My Recipes tab
                                    if viewModel.isLoadingRecipes {
                                        ProgressView()
                                            .frame(maxWidth: .infinity)
                                    } else if !viewModel.recipeListItems.isEmpty {
                                        RecipeGridView(
                                            recipeListItems: viewModel.recipeListItems,
                                            onFavoriteToggle: { recipe in
                                                        viewModel.toggleFavorite(recipe)
                                                    }
                                        )
                                    } else if let error = viewModel.errorRecipes {
                                        ContentUnavailableView(
                                            "Error",
                                            systemImage: "exclamationmark.triangle",
                                            description: Text(error)
                                        )
                                    } else {
                                        ContentUnavailableView(
                                            "No recipes yet",
                                            systemImage: "rectangle.on.rectangle.slash",
                                            description: Text("Start creating your first recipe!")
                                        )
                                    }
                                } else {
                                    // My Likes tab
                                    if viewModel.isLoadingLikes {
                                        ProgressView()
                                            .frame(maxWidth: .infinity)
                                    } else if !viewModel.likedRecipes.isEmpty {
                                        RecipeGridView(
                                            recipeListItems: viewModel.likedRecipes,
                                            onFavoriteToggle: { recipe in
                                                        viewModel.toggleFavorite(recipe)
                                                    }
                                        )
                                    } else if let error = viewModel.errorLikes {
                                        ContentUnavailableView(
                                            "Error",
                                            systemImage: "exclamationmark.triangle",
                                            description: Text(error)
                                        )
                                    } else {
                                        ContentUnavailableView(
                                            "No liked recipes",
                                            systemImage: "heart.slash",
                                            description: Text("You haven't liked any recipes yet")
                                        )
                                    }
                                }
                            }
                        }
                    }
                    .navigationTitle(TabItem.profile.title)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            HStack {
                                Button(action: {}) {
                                    Image(systemName: "bell")
                                        .foregroundColor(Theme.primary)
                                }
                                Button(action: {}) {
                                    Image(systemName: "ellipsis")
                                        .foregroundColor(Theme.primary)
                                }
                            }
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
                    "Profile not found",
                    systemImage: "questionmark.circle"
                )
            }
        }.task {
            // Initial load
            await viewModel.fetchUser()
            await viewModel.fetchRecipes()
            await viewModel.fetchLikedRecipes()
        }
        
    }
}
