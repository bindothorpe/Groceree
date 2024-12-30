//
//  APIRecipe.swift
//  Groceree
//
//  Created by Bindo Thorpe on 30/12/2024.
//

struct APIRecipe: Decodable {
    var id: String
    var author: Author
    var name: String
    var imageUrl: String
    var duration: Int
    var servings: Int
    var ingredients: [Ingredient]
    var instructions: [Instruction]
    var isFavorite: Int
    
    func toRecipe() -> Recipe {
        Recipe(
            id: id,
            author: author,
            name: name,
            imageUrl: "\(APIConstants.baseImageURL)\(imageUrl)",
            duration: duration,
            servings: servings,
            ingredients: ingredients,
            instructions: instructions,
            isFavorite: isFavorite != 0
        )
    }
}
