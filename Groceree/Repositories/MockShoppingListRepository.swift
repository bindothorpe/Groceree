//
//  MockShoppingListRepository.swift
//  Groceree
//
//  Created by Bindo Thorpe on 17/12/2024.
//

import Foundation

class MockShoppingListRepository: ShoppingListRepositoryProtocol {
    private var items: [ShoppingListItem] = [
        ShoppingListItem(id: "1", userId: "user1", label: "500 gr Pasta", isChecked: true),
        ShoppingListItem(id: "2", userId: "user1", label: "2 Eggs", isChecked: false),
        ShoppingListItem(id: "3", userId: "user1", label: "Salt", isChecked: false)
    ]
    
    private var recipeRepository: RecipeRepositoryProtocol
    
    init(recipeRepository: RecipeRepositoryProtocol = ServiceContainer.shared.recipeRepository) {
        self.recipeRepository = recipeRepository
    }
    
    func fetchShoppingListItems() async throws -> [ShoppingListItem] {
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000) // Simulate network delay
        return items
    }
    
    func addItem(_ label: String) async throws -> ShoppingListItem {
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        let newItem = ShoppingListItem(
            id: UUID().uuidString,
            userId: "user1", // In a real implementation, this would come from auth service
            label: label,
            isChecked: false
        )
        items.append(newItem)
        return newItem
    }
    
    func toggleItem(id: String) async throws {
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        guard let index = items.firstIndex(where: { $0.id == id }) else {
            throw ShoppingListError.itemNotFound
        }
        items[index].isChecked.toggle()
    }
    
    func deleteItem(id: String) async throws {
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        guard items.contains(where: { $0.id == id }) else {
            throw ShoppingListError.itemNotFound
        }
        items.removeAll { $0.id == id }
    }
    
    func clearList() async throws {
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        items.removeAll()
    }
    
    func addRecipeIngredients(recipeId: Int, servings: Int) async throws {
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        
        // Fetch recipe first
        let recipe = try await recipeRepository.fetchRecipe(id: recipeId)
        
        // Calculate serving ratio
        let ratio = Double(servings) / Double(recipe.servings)
        
        // Add each ingredient with adjusted amounts
        for ingredient in recipe.ingredients {
            let adjustedAmount = Int(Double(ingredient.amount) * ratio)
            let label = "\(adjustedAmount) \(ingredient.unit.rawValue) \(ingredient.name)"
            try await addItem(label)
        }
    }
}
