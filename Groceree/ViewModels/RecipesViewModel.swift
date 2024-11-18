//
//  RecipesViewModel.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//
import SwiftUI

class RecipesViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []    
    func fetchRecipes() {
        //TODO: Implement recipe fetching logic
    }
}
