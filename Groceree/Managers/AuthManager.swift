//
//  AuthManager.swift
//  Groceree
//
//  Created by Bindo Thorpe on 23/12/2024.
//

import Foundation

@MainActor
class AuthManager: ObservableObject {
    private let authRepository: AuthRepositoryProtocol
    private let apiClient: APIClient
    private let tokenKey = "auth_token"
    
    @Published var isAuthenticated = false
    @Published var isLoading = false
    @Published var error: String?
    
    init(authRepository: AuthRepositoryProtocol, apiClient: APIClient, initializeOnMain: Bool = true) {
        self.authRepository = authRepository
        self.apiClient = apiClient
        if initializeOnMain {
            loadStoredToken()
        }
    }
    
    private func loadStoredToken() {
        if let token = UserDefaults.standard.string(forKey: tokenKey) {
            apiClient.setAuthToken(token)
            isAuthenticated = true
        }
    }
    
    private func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
        apiClient.setAuthToken(token)
        isAuthenticated = true
    }
    
    func login(username: String, password: String) async {
        isLoading = true
        error = nil
        
        do {
            let token = try await authRepository.login(
                username: username,
                password: password
            )
            saveToken(token)
        } catch let error as APIError {
            self.error = error.errorDescription
        } catch {
            self.error = "An unexpected error occurred"
        }
        
        isLoading = false
    }
    
    func register(firstName: String, lastName: String, username: String, password: String) async {
        isLoading = true
        error = nil
        
        do {
            let token = try await authRepository.register(
                firstName: firstName,
                lastName: lastName,
                username: username,
                password: password
            )
            saveToken(token)
        } catch let error as APIError {
            self.error = error.errorDescription
        } catch {
            self.error = "An unexpected error occurred"
        }
        
        isLoading = false
    }
    
    func checkUsernameAvailability(username: String) async -> Bool {
        do {
            return try await authRepository.checkUsernameAvailability(username: username)
        } catch {
            return false
        }
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
        apiClient.setAuthToken(nil as String?)
        isAuthenticated = false
    }
}
