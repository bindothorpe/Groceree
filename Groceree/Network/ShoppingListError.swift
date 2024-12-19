//
//  ShoppingListError.swift
//  Groceree
//
//  Created by Bindo Thorpe on 17/12/2024.
//

import Foundation

enum ShoppingListError: LocalizedError {
    case itemNotFound
    case invalidData
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .itemNotFound:
            return "Shopping list item not found"
        case .invalidData:
            return "Invalid shopping list data"
        case .serverError(let message):
            return message
        }
    }
}
