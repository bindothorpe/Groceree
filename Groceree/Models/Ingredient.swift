//
//  Ingredient.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//
import Foundation

struct Ingredient: Identifiable, Hashable {
    let id: Int
    var name: String
    var amount: Int
    var unit: MeasurementUnit
}
