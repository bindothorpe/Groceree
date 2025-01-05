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
                Text("Shopping list")
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
                            }.tint(Theme.secondaryDarken)
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                        .listRowSeparator(.hidden)
                    }
                    
                    // New item field
                    HStack {
                        Image(systemName: "circle")
                            .foregroundColor(.gray)
                            .font(.system(size: 22))
                        
                        TextField("New product", text: $viewModel.newItemText)
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
            }
            .navigationTitle(TabItem.shoppingList.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        viewModel.showingActionSheet = true
                    }) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(Theme.primary)
                    }
                    .disabled(viewModel.items.isEmpty)
                    .confirmationDialog(
                        "List Options",
                        isPresented: $viewModel.showingActionSheet
                    ) {
                        if viewModel.hasSelectedItems {
                            Button("Remove Selected", role: .destructive) {
                                viewModel.removeSelectedItems()
                            }
                        }
                        Button("Remove All", role: .destructive) {
                            viewModel.clearList()
                        }
                        Button("Cancel", role: .cancel) {}
                    }
                }
                
            }
        }
        .onAppear {
            viewModel.fetchItems()
        }
    }
}
