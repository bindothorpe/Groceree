//
//  RecipeView.swift
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
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Image and author section
                    VStack(alignment: .leading, spacing: 0) {
                        recipeImage
                        Text("Geschreven door \(viewModel.recipe.author.firstName)")
                            .foregroundColor(.gray)
                            .padding()
                    }
                    .background(Color.white)
                    
                    VStack(alignment: .leading, spacing: 40) {
                        // General info section
                        generalInformation
                        
                        // Ingredients section
                        ingredientsInformation
                        
                        // Preperation section
                        preperationInformation
                    }
                    
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle(viewModel.recipe.name)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 8) {
                        Button(action: viewModel.toggleFavorite) {
                            Image(systemName: viewModel.recipe.isFavorite ? "heart.fill" : "heart")
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
                    actionSheetButtons
                }
                
        }
    
    
    private var recipeImage: some View {
        AsyncImage(url: URL(string: viewModel.recipe.imageUrl)) { image in
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
    }
    
    private var generalInformation: some View {
        
            VStack(alignment: .leading, spacing: 16) {
                Text("ALGEMEEN")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                    .padding(.horizontal)
                VStack(alignment: .leading, spacing: 16) {
                    
                    HStack {
                        Text("Porties")
                        Spacer()
                        Text("\(viewModel.recipe.servings)")
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text("Duratie")
                        Spacer()
                        Text(viewModel.recipe.formattedDuration())
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
    }
    
    private var ingredientsInformation: some View {
        VStack(alignment: .leading, spacing: 16){
            Text("INGREDIENTEN")
                .foregroundColor(.gray)
                .font(.system(size: 14))
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 16) {
                ForEach(viewModel.recipe.ingredients, id: \.self) { ingredient in
                    HStack(alignment: .center, spacing: 8) {
                        Text(ingredient.name)
                        Spacer()
                        Text("\(ingredient.amount)").foregroundColor(.gray)
                        Text(ingredient.unit.displayName).foregroundColor(.gray)
                    }
                    .padding(.vertical, 4)
                }
                
                Divider()
                
                Button(action: {
                    viewModel.selectedServings = viewModel.recipe.servings // Reset to default
                    viewModel.showingServingsSheet = true
                }) {
                    Text("Toevoegen aan winkellijstje")
                        .foregroundColor(Theme.primary)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .sheet(isPresented: $viewModel.showingServingsSheet) {
                    NavigationStack {
                        Form {
                            Stepper(
                                value: $viewModel.selectedServings,
                                in: 1...20
                            ) {
                                HStack {
                                    Text("Aantal porties")
                                    Spacer()
                                    Text("\(viewModel.selectedServings)")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .navigationTitle("Aantal porties")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Annuleer") {
                                    viewModel.showingServingsSheet = false
                                }
                            }
                            
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Voeg toe") {
                                    viewModel.addToShoppingList()
                                    viewModel.showingServingsSheet = false
                                }
                            }
                        }
                    }
                    .presentationDetents([.height(180)])
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
    }
    
    private var preperationInformation: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("BEREIDINGSWIJZE")
                .foregroundColor(.gray)
                .font(.system(size: 14))
                .padding(.horizontal)
            VStack(alignment: .leading, spacing: 16) {
                
                ForEach(viewModel.recipe.instructions, id: \.self) { instruction in
                    HStack(alignment: .top, spacing: 8) {
                        Text("\(instruction.step).")
                        Text(instruction.instruction)
                    }
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
