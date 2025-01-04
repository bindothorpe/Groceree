//
//  LocalShoppingListRepository.swift
//  Groceree
//
//  Created by Bindo Thorpe on 17/12/2024.
//

import Foundation

class LocalShoppingListRepository: ShoppingListRepositoryProtocol {
    private let fileManager = FileManager.default
    
    private var documentsDirectory: URL {
        fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private var shoppingListURL: URL {
        documentsDirectory.appendingPathComponent("shopping_list.json")
    }
    
    private var items: [ShoppingListItem] {
        get {
            guard fileManager.fileExists(atPath: shoppingListURL.path),
                  let data = try? Data(contentsOf: shoppingListURL),
                  let items = try? JSONDecoder().decode([ShoppingListItem].self, from: data) else {
                return []
            }
            return items
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else { return }
            try? data.write(to: shoppingListURL)
        }
    }
    
    func fetchShoppingListItems() -> [ShoppingListItem] {
        return items
    }
    
    func addItem(_ label: String) -> ShoppingListItem {
        let newItem = ShoppingListItem(
            id: UUID().uuidString,
            userId: "local",
            label: label,
            isChecked: false
        )
        var currentItems = items
        currentItems.append(newItem)
        items = currentItems
        return newItem
    }
    
    func toggleItem(id: String) {
        var currentItems = items
        if let index = currentItems.firstIndex(where: { $0.id == id }) {
            currentItems[index].isChecked.toggle()
            items = currentItems
        }
    }
    
    func deleteItem(id: String) {
        var currentItems = items
        currentItems.removeAll { $0.id == id }
        items = currentItems
    }
    
    func clearList() {
        items = []
    }
    
    func addRecipeIngredients(recipe: Recipe, servings: Int) {
        let ratio = Double(servings) / Double(recipe.servings)
        
        let newItems = recipe.ingredients.map { ingredient in
            let adjustedAmount = (Double(ingredient.amount) * ratio)
            let label = "\(adjustedAmount) \(ingredient.unit.rawValue) \(ingredient.name)"
            return ShoppingListItem(
                id: UUID().uuidString,
                userId: "local",
                label: label,
                isChecked: false
            )
        }
        
        var currentItems = items
        currentItems.append(contentsOf: newItems)
        items = currentItems
    }
}
