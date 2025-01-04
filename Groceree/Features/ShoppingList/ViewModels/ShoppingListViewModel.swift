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
    @Published var showingActionSheet = false

    private let repository: ShoppingListRepositoryProtocol

    init(
        repository: ShoppingListRepositoryProtocol = ServiceContainer.shared.shoppingListRepository
    ) {
        self.repository = repository
        fetchItems()
    }

    func fetchItems() {
        items = repository.fetchShoppingListItems()
    }

    func toggleItem(_ item: ShoppingListItem) {
        repository.toggleItem(id: item.id)
        fetchItems()
    }

    func addItem() {
        guard !newItemText.isEmpty else { return }
        _ = repository.addItem(newItemText)
        newItemText = ""
        fetchItems()
    }

    func clearList() {
        repository.clearList()
        fetchItems()
    }

    func removeItem(_ item: ShoppingListItem) {
        repository.deleteItem(id: item.id)
        fetchItems()
    }

    func removeSelectedItems() {
        let selectedItems = items.filter { $0.isChecked }
        selectedItems.forEach { item in
            repository.deleteItem(id: item.id)
        }
        fetchItems()
    }

    var hasSelectedItems: Bool {
        items.contains { $0.isChecked }
    }
}
