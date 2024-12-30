//
//  NavigationBar.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//
import SwiftUI

struct NavigationBar: View {
    @StateObject private var viewModel = NavigationViewModel()
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            RecipesView()
                .tabItem {
                    Label(TabItem.recipes.title,
                          systemImage: TabItem.recipes.icon)
                }
                .tag(TabItem.recipes)
            
            ShoppingListView()
                .tabItem {
                    Label(TabItem.shoppingList.title,
                          systemImage: TabItem.shoppingList.icon)
                }
                .tag(TabItem.shoppingList)
            
            ProfileView()
                .tabItem {
                    Label(TabItem.profile.title,
                          systemImage: TabItem.profile.icon)
                }
                .tag(TabItem.profile)
        }
        .tint(Theme.primary)
        .background(Theme.backgroundDarken)
    }
}
