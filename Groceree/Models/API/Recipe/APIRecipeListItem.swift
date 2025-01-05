//
//  APIRecipeListItem.swift
//  Groceree
//
//  Created by Bindo Thorpe on 30/12/2024.
//

struct APIRecipeListItem: Decodable {
        let id: String
        let name: String
        let imageUrl: String
        let duration: Int
        let isFavorite: Int
        
        func toRecipeListItem() -> RecipeListItem {
            RecipeListItem(
                id: id,
                name: name,
                imageUrl: "\(APIConstants.baseImageURL)\(imageUrl)",
                duration: duration,
                isFavorite: isFavorite != 0
            )
        }
    }
