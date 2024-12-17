//
//  ShoppingListRepositoryProtocol.swift
//  Groceree
//
//  Created by Bindo Thorpe on 17/12/2024.
//

import Foundation

protocol ShoppingListRepositoryProtocol {
    func fetchShoppingListItems() -> [ShoppingListItem]
    func addItem(_ label: String) -> ShoppingListItem
    func toggleItem(id: String)
    func deleteItem(id: String)
    func clearList()
    func addRecipeIngredients(recipe: Recipe, servings: Int)
}
