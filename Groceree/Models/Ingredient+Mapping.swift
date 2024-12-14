//
//  Ingredient+Mapping.swift
//  Groceree
//
//  Created by Bindo Thorpe on 13/12/2024.
//

extension Ingredient {
    static func from(apiModel: APIIngredient) -> Ingredient {
        Ingredient(
            id: apiModel.id,
            name: apiModel.name,
            amount: apiModel.amount
        )
    }
}
