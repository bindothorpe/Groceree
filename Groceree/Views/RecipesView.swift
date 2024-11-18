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
            Text("Recepten")
                .navigationTitle(TabItem.recipes.title)
        }
        .onAppear {
            viewModel.fetchRecipes()
        }
    }
}
