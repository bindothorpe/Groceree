//
//  APIRecipeListResponse.swift
//  Groceree
//
//  Created by Bindo Thorpe on 30/12/2024.
//

struct APIRecipeListResponse: Decodable {
    let recipes: [APIRecipeListItem]
}