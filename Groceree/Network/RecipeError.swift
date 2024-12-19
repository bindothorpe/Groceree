//
//  RecipeError.swift
//  Groceree
//
//  Created by Bindo Thorpe on 15/12/2024.
//

import Foundation

enum RecipeError: LocalizedError {
    case notFound
    case invalidData
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .notFound:
            return "Recipe not found"
        case .invalidData:
            return "Invalid recipe data"
        case .serverError(let message):
            return message
        }
    }
}
