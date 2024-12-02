//
//  GroceryListItem.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//
import Foundation

struct ShoppingListItem: Identifiable, Codable {
    let id: String
    let userId: String
    var label: String
    var isChecked: Bool
}
