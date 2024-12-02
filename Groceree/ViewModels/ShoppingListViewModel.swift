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
    
    func fetchItems() {
        // Temporary sample data
        items = [
            ShoppingListItem(id: "1", userId: "user1", label: "500 gr Pasta", isChecked: true),
            ShoppingListItem(id: "2", userId: "user1", label: "2 Eieren", isChecked: false),
            ShoppingListItem(id: "3", userId: "user1", label: "Zout", isChecked: false)
        ]
    }
    
    func toggleItem(_ item: ShoppingListItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isChecked.toggle()
        }
    }
    
    func addItem() {
        guard !newItemText.isEmpty else { return }
        let newItem = ShoppingListItem(
            id: UUID().uuidString,
            userId: "user1",
            label: newItemText,
            isChecked: false
        )
        items.append(newItem)
        newItemText = ""
    }
    
    func clearList() {
        items.removeAll()
    }
    
    func removeItem(_ item: ShoppingListItem) {
        items.removeAll { $0.id == item.id }
    }
}
