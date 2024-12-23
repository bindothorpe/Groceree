//
//  AuthRepository.swift
//  Groceree
//
//  Created by Bindo Thorpe on 23/12/2024.
//

class AuthRepository: AuthRepositoryProtocol {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func login(username: String, password: String) async throws -> String {
        let request = APILoginRequest(username: username, password: password)
        let response: APIAuthResponse = try await apiClient.fetch(
            "/api/auth/login",
            method: "POST",
            body: request
        )
        return response.token
    }
    
    func register(firstName: String, lastName: String, username: String, password: String) async throws -> String {
        let request = APIRegisterRequest(
            firstName: firstName,
            lastName: lastName,
            username: username,
            password: password
        )
        let response: APIAuthResponse = try await apiClient.fetch(
            "/api/auth/register",
            method: "POST",
            body: request
        )
        return response.token
    }
    
    func checkUsernameAvailability(username: String) async throws -> Bool {
        let response: UsernameAvailabilityResponse = try await apiClient.fetch(
            "/api/auth/check-username/\(username)"
        )
        return response.available
    }
}
