//
//  APIError.swift
//  Groceree
//
//  Created by Bindo Thorpe on 23/12/2024.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidRequest
    case unauthorized
    case notFound
    case serverError(String)
    case networkError(Error)
    case decodingError(Error)
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidRequest:
            return "Invalid request"
        case .unauthorized:
            return "Unauthorized - Please log in again"
        case .notFound:
            return "Resource not found"
        case .serverError(let message):
            return message
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .decodingError(let error):
            return "Failed to process response: \(error.localizedDescription)"
        case .unknownError:
            return "An unknown error occurred"
        }
    }
}
