//
//  ServiceContainer.swift
//  Groceree
//
//  Created by Bindo Thorpe on 15/12/2024.
//

import Foundation

class ServiceContainer {
    static let shared = ServiceContainer()
    
    let apiClient: APIClient
    
    let recipeRepository: RecipeRepositoryProtocol
    let shoppingListRepository: ShoppingListRepositoryProtocol
    let userRepository: UserRepositoryProtocol
    let authRepository: AuthRepositoryProtocol
    
    let authManager: AuthManager
    
    private init() {
        self.apiClient = APIClient(baseURL: APIConstants.baseURL)
        
        self.authRepository = AuthRepository(apiClient: apiClient)
        self.recipeRepository = MockRecipeRepository()
        self.shoppingListRepository = LocalShoppingListRepository()
        self.userRepository = MockUserRepository()
        
        self.authManager = AuthManager(authRepository: authRepository, apiClient: apiClient)
                
        // Initialize auth manager on main actor
        Task { @MainActor in
            self.authManager.initialize()
        }
    }
}
