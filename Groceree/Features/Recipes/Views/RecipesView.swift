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
                CreateRecipeView()
            }
        }
        .task {
            await viewModel.fetchRecipes()
        }
    }
}
