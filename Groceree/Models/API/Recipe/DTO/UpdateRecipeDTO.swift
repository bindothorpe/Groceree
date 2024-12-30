//
//  UpdateRecipeDTO.swift
//  Groceree
//
//  Created by Bindo Thorpe on 30/12/2024.
//

struct UpdateRecipeDTO: Encodable {
    let id: String
    let name: String
    let duration: Int
    let servings: Int
    let ingredients: [UpdateIngredientDTO]
    let instructions: [UpdateInstructionDTO]
}
