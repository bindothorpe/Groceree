//
//  APIRecipe.swift
//  Groceree
//
//  Created by Bindo Thorpe on 13/12/2024.
//

struct APIRecipe: Codable {
    let id: Int
    let name: String
    let imageUrl: String?
    let duration: Int
    let servings: Int
    let isFavorite: Bool
    let ingredients: [APIIngredient]
    let instructions: [APIInstruction]
}
