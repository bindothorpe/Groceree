//
//  TabItem.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//

enum TabItem {
    case recipes, shoppingList, profile
    
    var title: String {
        switch self {
        case .recipes: return "Recipes"
        case .shoppingList: return "Shopping list"
        case .profile: return "Profile"
        }
    }
    
    var icon: String {
        switch self {
        case .recipes: return "house.fill"
        case .shoppingList: return "cart.fill"
        case .profile: return "person.fill"
        }
    }
}
