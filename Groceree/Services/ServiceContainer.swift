//
//  ServiceContainer.swift
//  Groceree
//
//  Created by Bindo Thorpe on 15/12/2024.
//

import Foundation

class ServiceContainer {
    static let shared = ServiceContainer()
    
    let recipeRepository: RecipeRepositoryProtocol
    let shoppingListRepository: ShoppingListRepositoryProtocol
    
    private init() {
        self.recipeRepository = MockRecipeRepository()
        self.shoppingListRepository = LocalShoppingListRepository()
    }
}