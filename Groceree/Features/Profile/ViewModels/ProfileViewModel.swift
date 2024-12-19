//
//  ProfileViewModel.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var userId: String
    @Published var user: User?
    
    @Published var isLoading = false
    @Published var error: String?
    
    private let userRepository: UserRepositoryProtocol
    
    init(
        userId: String,
        userRepository: UserRepositoryProtocol = ServiceContainer.shared.userRepository
    ) {
        self.userId = userId
        self.userRepository = userRepository
        
        Task {
            await fetchUser()
        }
    }
        
    @MainActor
    func fetchUser() async {
        isLoading = true
        error = nil
        
        do {
            user = try await userRepository.fetchUser(id: userId)
        } catch {
            self.error = error.localizedDescription
        }
        
        isLoading = false
    }
}
