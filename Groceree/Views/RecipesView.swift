//
//  RecipesView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//
import SwiftUI

struct RecipesView: View {
    @StateObject private var viewModel = RecipesViewModel()
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    if viewModel.isSearching {
                        ForEach(viewModel.searchResults) { recipeListItem in
                            RecipeCard(recipeListItem: recipeListItem) {
                                viewModel.toggleFavorite(recipeListItem)
                            }.frame(height: 280)
                        }
                    } else {
                        ForEach(viewModel.recipeListItems) { recipeListItem in
                            RecipeCard(recipeListItem: recipeListItem) {
                                viewModel.toggleFavorite(recipeListItem)
                            }.frame(height: 280)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle(TabItem.recipes.title)
            .navigationBarTitleDisplayMode(.inline)
            .searchable(
                text: $viewModel.searchQuery,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search recipes..."
            )
            .textInputAutocapitalization(.never)
            .onChange(of: viewModel.searchQuery) {
                viewModel.fetchSearchResults()
            }
            .overlay {
                if viewModel.isSearching && viewModel.searchResults.isEmpty {
                    ContentUnavailableView(
                        "No recipes found",
                        systemImage: "magnifyingglass",
                        description: Text("No results for **\(viewModel.searchQuery)**")
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
        .onAppear {
            viewModel.fetchRecipes()
        }
    }
}
