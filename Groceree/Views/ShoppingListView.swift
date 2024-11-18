//
//  ShoppingListView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//
import SwiftUI

struct ShoppingListView: View {
    @StateObject private var viewModel = ShoppingListViewModel()
    
    var body: some View {
        NavigationStack {
            Text("Winkellijst")
                .navigationTitle(TabItem.shoppingList.title)
        }
        .onAppear {
            viewModel.fetchItems()
        }
    }
}
