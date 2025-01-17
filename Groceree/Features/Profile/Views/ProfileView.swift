import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel: ProfileViewModel
    @EnvironmentObject private var authViewModel: AuthViewModel
    @State private var showingActionSheet = false
    @State private var showingUpdateSheet = false
    
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
                                    Text(viewModel.isCurrentUser ? "My Recipes" : "Recipes").tag(0)
                                    Text(viewModel.isCurrentUser ? "My Likes" : "Likes").tag(1)
                                }
                                .pickerStyle(.segmented)
                                .padding(.horizontal)
                                .padding(.bottom, 24)
                                
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
                    .toast(
                        style: .success,
                        isPresented: $viewModel.showingSuccessMessage
                    ) {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text("Updated profile")
                        }
                    }
                    .navigationTitle(TabItem.profile.title)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            HStack {
                                if(viewModel.isCurrentUser) {
                                    Button(action: {
                                        showingActionSheet = true
                                    }) {
                                        Image(systemName: "ellipsis")
                                            .foregroundColor(Theme.primary)
                                    }
                                    .confirmationDialog(
                                        "Profile Options",
                                        isPresented: $showingActionSheet
                                    ) {
                                        Button("Edit Profile", action: { showingUpdateSheet = true })
                                        Button("Logout", role: .destructive) {
                                            authViewModel.logout()
                                        }
                                        Button("Cancel", role: .cancel) {}
                                    }
                                }
                            }
                        }
                    }
                    .sheet(isPresented: $showingUpdateSheet) {
                        if let currentUser = viewModel.user {
                            UpdateUserSheet(
                                user: currentUser,
                                onUpdateSuccess: {
                                    Task {
                                        viewModel.showingSuccessMessage = true
                                        await viewModel.fetchUser()
                                    }
                                }
                            )
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
            await viewModel.fetchUser()
            await viewModel.fetchRecipes()
            await viewModel.fetchLikedRecipes()
        }
    }
}
