//
//  AuthViewModel.swift
//  Groceree
//
//  Created by Bindo Thorpe on 24/12/2024.
//

import Foundation
import SwiftUI

@MainActor
class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var isCheckingAuth = true
    
    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol = ServiceContainer.shared.authRepository) {
        self.authRepository = authRepository
        Task {
            await checkAuthenticationStatus()
        }
    }
    
    func checkAuthenticationStatus() async {
        do {
            let _ = try KeychainManager.shared.getToken()
            isAuthenticated = true
        } catch {
            isAuthenticated = false
        }
        isCheckingAuth = false
    }
    
    func logout() {
        do {
            try KeychainManager.shared.deleteToken()
            isAuthenticated = false
        } catch {
            print("Error logging out: \(error)")
        }
    }
}
