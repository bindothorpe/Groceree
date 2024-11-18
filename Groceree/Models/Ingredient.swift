//
//  Ingredient.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//
import Foundation

struct Ingredient: Identifiable, Codable {
    let id: String
    var name: String
    var amount: String
}
