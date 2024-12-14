//
//  APIRecipeListItem.swift
//  Groceree
//
//  Created by Bindo Thorpe on 13/12/2024.
//

struct APIRecipeListItem: Codable {
    let id: Int
    let name: String
    let imageUrl: String?
    let duration: Int
}
