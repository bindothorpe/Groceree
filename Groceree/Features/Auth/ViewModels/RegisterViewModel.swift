//
//  RegisterViewModel.swift
//  Groceree
//
//  Created by Bindo Thorpe on 24/12/2024.
//

import Foundation

@MainActor
class RegisterViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var username = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var error: String?
    
    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol = ServiceContainer.shared.authRepository) {
        self.authRepository = authRepository
    }
    
    func register() async {
        isLoading = true
        error = nil
        
        do {
            let token = try await authRepository.register(
                firstName: firstName,
                lastName: lastName,
                username: username,
                password: password
            )
            try KeychainManager.shared.saveToken(token)
        } catch {
            self.error = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func checkUsernameAvailability() async {
        guard !username.isEmpty else { return }
        
        do {
            let isAvailable = try await authRepository.checkUsernameAvailability(username: username)
            if !isAvailable {
                error = "Username is already taken"
            } else {
                error = nil
            }
        } catch let error as Error {
            self.error = error.localizedDescription
        }
    }
    
    var isRegisterButtonDisabled: Bool {
        firstName.isEmpty ||
        lastName.isEmpty ||
        username.isEmpty ||
        password.isEmpty ||
        isLoading
    }
}
