//
//  MockAuthRepository.swift
//  Groceree
//
//  Created by Bindo Thorpe on 23/12/2024.
//

class MockAuthRepository: AuthRepositoryProtocol {
    func login(username: String, password: String) async throws -> String {
        // For testing, return a fake token if credentials match test data
        if username == "test" && password == "password" {
            return "mock_auth_token"
        }
        throw APIError.unauthorized
    }
    
    func register(firstName: String, lastName: String, username: String, password: String) async throws -> String {
        // Simulate successful registration
        return "mock_auth_token"
    }
    
    func checkUsernameAvailability(username: String) async throws -> Bool {
        // Simulate username check - only "test" is taken
        return username != "test"
    }
}
