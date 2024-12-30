//
//  UserRepository.swift
//  Groceree
//
//  Created by Bindo Thorpe on 24/12/2024.
//

class UserRepository: UserRepositoryProtocol {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchUser(id: String) async throws -> User {
        let response: APIUserResponse = try await apiClient.fetch("/api/users/\(id)")
        return response.user
    }
    
    func fetchCurrentUser() async throws -> User {
        let response: APIUserResponse = try await apiClient.fetch("/api/users/me")
        return response.user
    }
}
