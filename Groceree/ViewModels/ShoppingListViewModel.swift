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
    @Published var isLoading = false
    @Published var error: String?
    
    private let repository: ShoppingListRepositoryProtocol
    
    init(repository: ShoppingListRepositoryProtocol = ServiceContainer.shared.shoppingListRepository) {
        self.repository = repository
    }
    
    @MainActor
    func fetchItems() {
        Task {
            isLoading = true
            error = nil
            
            do {
                items = try await repository.fetchShoppingListItems()
            } catch {
                self.error = error.localizedDescription
            }
            
            isLoading = false
        }
    }
    
    @MainActor
    func toggleItem(_ item: ShoppingListItem) {
        Task {
            do {
                try await repository.toggleItem(id: item.id)
                if let index = items.firstIndex(where: { $0.id == item.id }) {
                    items[index].isChecked.toggle()
                }
            } catch {
                self.error = error.localizedDescription
            }
        }
    }
    
    @MainActor
    func addItem() {
        guard !newItemText.isEmpty else { return }
        
        Task {
            do {
                let newItem = try await repository.addItem(newItemText)
                items.append(newItem)
                newItemText = ""
            } catch {
                self.error = error.localizedDescription
            }
        }
    }
    
    @MainActor
    func clearList() {
        Task {
            do {
                try await repository.clearList()
                items.removeAll()
            } catch {
                self.error = error.localizedDescription
            }
        }
    }
    
    @MainActor
    func removeItem(_ item: ShoppingListItem) {
        Task {
            do {
                try await repository.deleteItem(id: item.id)
                items.removeAll { $0.id == item.id }
            } catch {
                self.error = error.localizedDescription
            }
        }
    }
}
