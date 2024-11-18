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
        case .recipes: return "Recepten"
        case .shoppingList: return "Winkellijst"
        case .profile: return "Profiel"
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
