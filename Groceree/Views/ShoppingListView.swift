//
//  ShoppingListView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//
import SwiftUI

struct ShoppingListView: View {
    @StateObject private var viewModel = ShoppingListViewModel()
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header
                Text("Boodschappenlijstje")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(uiColor: .systemBackground))
                
                // List
                List {
                    ForEach(viewModel.items) { item in
                        ShoppingListItemView(item: item) {
                            viewModel.toggleItem(item)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                viewModel.removeItem(item)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                        .listRowSeparator(.hidden)
                    }
                    
                    // New item field
                    HStack {
                        Image(systemName: "circle")
                            .foregroundColor(.gray)
                            .font(.system(size: 22))
                        
                        TextField("Nieuw product", text: $viewModel.newItemText)
                            .focused($isTextFieldFocused)
                            .foregroundColor(.gray)
                            .onSubmit {
                                viewModel.addItem()
                            }
                        
                        if !viewModel.newItemText.isEmpty {
                            Button(action: { viewModel.newItemText = "" }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                
                // Clear list button
                if !viewModel.items.isEmpty {
                    Button(action: viewModel.clearList) {
                        Text("Clear List")
                            .foregroundColor(Theme.primary)
                            .padding()
                    }
                }
            }
            .navigationTitle(TabItem.shoppingList.title)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.fetchItems()
        }
    }
}
