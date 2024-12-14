//
//  RecipesView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//
import SwiftUI

struct RecipesView: View {
    @EnvironmentObject private var environment: APIEnvironment
    
    var body: some View {
        RecipesViewContent(api: environment.api)
    }
}
private struct RecipesViewContent: View {
    @StateObject private var viewModel: RecipesViewModel
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    init(api: GrocereeAPIProtocol) {
        // Initialize viewModel with the passed API
        _viewModel = StateObject(wrappedValue: RecipesViewModel(api: api))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.recipes, id: \.id) { recipe in
                        RecipeCard(recipe: recipe) {
                            // Toggle favorite functionality will come later
                        }.frame(height: 280)
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
