//
//  Recipe+Mapping.swift
//  Groceree
//
//  Created by Bindo Thorpe on 13/12/2024.
//

extension Recipe {
    static func from(apiModel: APIRecipe) -> Recipe {
            Recipe(
                id: apiModel.id,
                name: apiModel.name,
                imageUrl: apiModel.imageUrl ?? "", //TODO: Add placeholder image
                duration: apiModel.duration,
                servings: apiModel.servings,
                isFavorite: apiModel.isFavorite,
                ingredients: apiModel.ingredients.map {Ingredient.from(apiModel: $0)},
                instructions: apiModel.instructions.map { Instruction.from(apiModel: $0)}
            )
    }
}
