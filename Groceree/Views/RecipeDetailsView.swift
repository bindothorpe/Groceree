//
//  RecipeView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 13/12/2024.
//

import SwiftUI

struct RecipeDetailView: View {
    @EnvironmentObject private var environment: APIEnvironment
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
                        // Image and author section
                        VStack(alignment: .leading, spacing: 0) {
                            
                            // Image
                            AsyncImage(url: URL(string: recipe.imageUrl)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.2))
                                    .overlay(
                                        ProgressView()
                                    )
                            }
                            .frame(height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .padding(.horizontal)
                            
                            Text("Geschreven door Autheur")
                                .foregroundColor(.gray)
                                .padding()
                        }
                        .background(Color.white)
                        
                        VStack(alignment: .leading, spacing: 40) {
                            
                            // General info section
                            VStack(alignment: .leading, spacing: 16) {
                                Text("ALGEMEEN")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14))
                                    .padding(.horizontal)
                                VStack(alignment: .leading, spacing: 16) {
                                    
                                    HStack {
                                        Text("Porties")
                                        Spacer()
                                        Text("\(recipe.portionAmount)")
                                            .foregroundColor(.gray)
                                    }
                                    
                                    HStack {
                                        Text("Duratie")
                                        Spacer()
                                        Text(recipe.formattedDuration)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.white)
                                        .shadow(radius: 4)
                                )
                                .padding(.horizontal)
                            }
                            
                            // Ingredients section
                            VStack(alignment: .leading, spacing: 16){
                                Text("INGREDIENTEN")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14))
                                    .padding(.horizontal)
                                VStack(alignment: .leading, spacing: 16) {
                                    
                                    ForEach(viewModel.recipe.ingredientIds, id: \.self) { ingredientId in
                                        HStack(alignment: .center, spacing: 0) {
                                            Text("Sample ingredient")
                                            Spacer()
                                            Text("Amount")
                                        }
                                        .padding(.vertical, 4)
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.white)
                                        .shadow(radius: 4)
                                )
                                .padding(.horizontal)
                            }
                            
                            // Preperation section
                            VStack(alignment: .leading, spacing: 16) {
                                Text("BEREIDINGSWIJZE")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14))
                                    .padding(.horizontal)
                                VStack(alignment: .leading, spacing: 16) {
                                    Text(viewModel.recipe.preparation)
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.white)
                                        .shadow(radius: 4)
                                )
                                .padding(.horizontal)
                            }
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
                            
                            Button(action: viewModel.addToBookmarks) {
                                Image(systemName: "bookmark")
                                    .foregroundColor(Theme.primary)
                            }
                            
                            Button(action: { viewModel.showingActionSheet = true }) {
                                Image(systemName: "ellipsis")
                                    .foregroundColor(Theme.primary)
                            }
                        }
                    }
                }
            } else {
                Text("Failed to load recipe")
            }
        }
        .alert("Error", isPresented: Binding(
            get: { viewModel.errorMessage != nil },
            set: { if !$0 { viewModel.errorMessage = nil } }
        )) {
            Button("OK", role: .cancel) { }
        } message: {
            if let error = viewModel.errorMessage {
                Text(error)
            }
        }
        .onAppear {
            viewModel.setAPI(environment.api)
            viewModel.fetchRecipe()
        }
    }
    
    
    private var actionSheetButtons: some View {
        Group {
            Button("Markeer als favoriet", action: viewModel.toggleFavorite)
            Button("Recept bewaren", action: viewModel.addToBookmarks)
            Button("Toevoegen aan folder", action: viewModel.addToFolder)
            Button("Toevoegen aan winkellijst", action: viewModel.addToShoppingList)
            Button("Wijzig", action: viewModel.editRecipe)
            Button("Cancel", role: .cancel) { }
        }
    }
}
