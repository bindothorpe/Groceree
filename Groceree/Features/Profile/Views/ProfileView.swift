import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel: ProfileViewModel
    @EnvironmentObject private var authViewModel: AuthViewModel
    @State private var showingActionSheet = false
    
    init(userId: String? = nil) {
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
                            
                            VStack(alignment: .leading, spacing: 16) {
                                Picker("", selection: $viewModel.selectedTab) {
                                    Text("My Recipes").tag(0)
                                    Text("My Likes").tag(1)
                                }
                                .pickerStyle(.segmented)
                                .padding(.horizontal)
                                
                                if viewModel.selectedTab == 0 {
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
                                Button(action: {
                                    showingActionSheet = true
                                }) {
                                    Image(systemName: "ellipsis")
                                        .foregroundColor(Theme.primary)
                                }
                            }
                        }
                    }
                    .confirmationDialog(
                        "Profile Options",
                        isPresented: $showingActionSheet
                    ) {
                        Button("Edit Profile", action: {})
                        Button("Settings", action: {})
                        Button("Logout", role: .destructive) {
                            authViewModel.logout()
                        }
                        Button("Cancel", role: .cancel) {}
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
            await viewModel.fetchUser()
            await viewModel.fetchRecipes()
            await viewModel.fetchLikedRecipes()
        }
    }
}
