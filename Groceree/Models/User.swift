//
//  User.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    var username: String
    var avatarUrl: String
    var bio: String
    var recipeIds: [String]
    var likedRecipeIds: [String]
}
