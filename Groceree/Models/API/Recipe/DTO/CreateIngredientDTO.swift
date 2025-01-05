//
//  CreateIngredientDTO.swift
//  Groceree
//
//  Created by Bindo Thorpe on 30/12/2024.
//

struct CreateIngredientDTO: Encodable {
    let name: String
    let amount: Int
    let unit: MeasurementUnit
}
