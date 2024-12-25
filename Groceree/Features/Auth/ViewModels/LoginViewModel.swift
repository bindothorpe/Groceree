//
//  LoginViewModel.swift
//  Groceree
//
//  Created by Bindo Thorpe on 24/12/2024.
//

import Foundation
import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var error: String?
    
    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol = ServiceContainer.shared.authRepository) {
        self.authRepository = authRepository
    }
    
    func login() async {
        isLoading = true
        error = nil
        
        do {
            let _ = try await authRepository.login(username: username, password: password)
        } catch is APIAuthError {
            self.error = "Invalid credentials"
        } catch {
            self.error = error.localizedDescription
        }
        
        isLoading = false
    }
    
    var isLoginButtonDisabled: Bool {
        username.isEmpty || password.isEmpty || isLoading
    }
}
