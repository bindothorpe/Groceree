//
//  ShoppingListRepositoryProtocol.swift
//  Groceree
//
//  Created by Bindo Thorpe on 17/12/2024.
//

import Foundation

protocol ShoppingListRepositoryProtocol {
    func fetchShoppingListItems() async throws -> [ShoppingListItem]
    func addItem(_ label: String) async throws -> ShoppingListItem
    func toggleItem(id: String) async throws
    func deleteItem(id: String) async throws
    func clearList() async throws
    func addRecipeIngredients(recipeId: Int, servings: Int) async throws
}
