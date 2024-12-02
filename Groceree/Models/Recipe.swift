//
//  Recipe.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//
import Foundation

struct Recipe: Identifiable, Codable {
    let id: String
    var name: String
    var imageUrl: String
    var preparation: String
    var duration: Int64
    var portionAmount: Int
    var ingredientIds: [String]
    var isFavorite: Bool
}
