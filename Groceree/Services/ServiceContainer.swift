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
    
    private init() {
        self.apiClient = APIClient(baseURL: APIConstants.baseURL, baseImageUrl: APIConstants.baseImageURL)
        
        self.authRepository = AuthRepository(apiClient: apiClient)
        self.recipeRepository = MockRecipeRepository()
        self.shoppingListRepository = LocalShoppingListRepository()
        self.userRepository = MockUserRepository()
    }
}
