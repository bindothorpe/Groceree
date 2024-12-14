//
//  RecipeListItem+Mapping.swift
//  Groceree
//
//  Created by Bindo Thorpe on 13/12/2024.
//

extension RecipeListItem {
    static func from(apiModel: APIRecipeListItem) -> RecipeListItem {
            RecipeListItem(
                id: apiModel.id,
                name: apiModel.name,
                imageUrl: apiModel.imageUrl,
                duration: apiModel.duration
            )
    }
}
