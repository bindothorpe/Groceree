//
//  CreateRecipeRequest.swift
//  Groceree
//
//  Created by Bindo Thorpe on 13/12/2024.
//

struct CreateRecipeRequest: Codable {
    var name: String
    let imageUrl: String?
    let duration: Int
    let servings: Int
    let ingredients: [CreateIngredientRequest]
    let instructions: [CreateInstructionRequest]
}
