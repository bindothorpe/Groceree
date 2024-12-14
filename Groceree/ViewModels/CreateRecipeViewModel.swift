//
//  CreateRecipeViewModel.swift
//  Groceree
//
//  Created by Bindo Thorpe on 02/12/2024.
//
import SwiftUI

class CreateRecipeViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var hours: Int = 0
    @Published var minutes: Int = 30
    @Published var portions: Int = 2
    @Published var ingredients: [Ingredient] = []
    @Published var preparation: String = ""
    
    func addIngredient() {
        ingredients.append(Ingredient(
            id: 1,
            name: "",
            amount: ""
        ))
    }
    
    var isValid: Bool {
        let isNameValid = !name.isEmpty && name.count <= 75
        let isDurationValid = hours > 0 || minutes > 0
        let isPortionsValid = portions > 0
        let hasIngredients = !ingredients.isEmpty
        let isPreparationValid = !preparation.isEmpty
        
        return isNameValid &&
               isDurationValid &&
               isPortionsValid &&
               hasIngredients &&
               isPreparationValid
    }
    
    func createRecipe() {
        
    }
}
