//
//  ShoppingListViewModel.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//
import SwiftUI

class ShoppingListViewModel: ObservableObject {
    @Published var items: [ShoppingListItem] = []
    @Published var newItemText: String = ""
    
    private let repository: ShoppingListRepositoryProtocol
    
    init(repository: ShoppingListRepositoryProtocol = ServiceContainer.shared.shoppingListRepository) {
        self.repository = repository
        fetchItems()
    }
    
    func fetchItems() {
        items = repository.fetchShoppingListItems()
    }
    
    func toggleItem(_ item: ShoppingListItem) {
        repository.toggleItem(id: item.id)
        fetchItems() // Refresh the list after toggling
    }
    
    func addItem() {
        guard !newItemText.isEmpty else { return }
        _ = repository.addItem(newItemText)
        newItemText = ""
        fetchItems() // Refresh the list after adding
    }
    
    func clearList() {
        repository.clearList()
        fetchItems() // Refresh the list after clearing
    }
    
    func removeItem(_ item: ShoppingListItem) {
        repository.deleteItem(id: item.id)
        fetchItems() // Refresh the list after removing
    }
}
