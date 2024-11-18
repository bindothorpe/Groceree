//
//  ShoppingListViewModel.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//
import SwiftUI

class ShoppingListViewModel: ObservableObject {
    @Published var items: [GroceryListItem] = []
    
    func fetchItems() {
        //TODO: Implement shopping list fetching logic
    }
}
