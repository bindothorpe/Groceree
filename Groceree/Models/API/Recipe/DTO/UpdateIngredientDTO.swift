//
//  UpdateIngredientDTO.swift
//  Groceree
//
//  Created by Bindo Thorpe on 30/12/2024.
//

struct UpdateIngredientDTO: Encodable {
    let id: String
    let name: String
    let amount: Int
    let unit: String // Using the raw value of MeasurementUnit
}
