//
//  RecipesView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//
import SwiftUI

struct RecipesView: View {
    @StateObject private var viewModel = RecipesViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                RecipeGridView(
                    recipeListItems: viewModel.isSearching ? viewModel.searchResults : viewModel.recipeListItems,
                    onFavoriteToggle: viewModel.toggleFavorite
                )
            }
            .refreshable {
                await viewModel.fetchRecipes()
            }
            .toast(
                style: .success,
                isPresented: $viewModel.showingCreateSuccessMessage
            ) {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                    Text("Created recipe")
                }
            }
            .navigationTitle(TabItem.recipes.title)
            .navigationBarTitleDisplayMode(.inline)
            .searchable(
                text: $viewModel.searchQuery,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search recipes..."
            )
            .textInputAutocapitalization(.never)
            .overlay {
                if viewModel.isSearching && viewModel.searchResults.isEmpty {
                    ContentUnavailableView(
                        "No recipes found",
                        systemImage: "magnifyingglass",
                        description: Text("No results for \(viewModel.searchQuery)")
                    )
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        viewModel.showingCreateRecipe = true
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(Theme.primary)
                            .font(.system(size: 20, weight: .semibold))
                    }
                }
            }
            .sheet(isPresented: $viewModel.showingCreateRecipe) {
                RecipeFormView(mode: .create, onActionSuccess: {
                    Task {
                        await viewModel.fetchRecipes()
                        viewModel.showingCreateRecipe = false
                        viewModel.showingCreateSuccessMessage = true
                        
                    }
                })
            }
        }
        .task {
            await viewModel.fetchRecipes()
        }
    }
}
