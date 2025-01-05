//
//  CreateRecipeDTO.swift
//  Groceree
//
//  Created by Bindo Thorpe on 30/12/2024.
//

struct CreateRecipeDTO: Encodable {
    let name: String
    let duration: Int
    let servings: Int
    let ingredients: [CreateIngredientDTO]
    let instructions: [CreateInstructionDTO]
}
