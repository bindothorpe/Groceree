//
//  UserError.swift
//  Groceree
//
//  Created by Bindo Thorpe on 19/12/2024.
//

import Foundation

enum UserError: LocalizedError {
    case notFound
    case invalidData
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .notFound:
            return "User not found"
        case .invalidData:
            return "Invalid user data"
        case .serverError(let message):
            return message
        }
    }
}
