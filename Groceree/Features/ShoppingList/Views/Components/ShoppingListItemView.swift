//
//  GroceryListItemView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 02/12/2024.
//

import SwiftUI

struct ShoppingListItemView: View {
    let item: ShoppingListItem
    let onToggle: () -> Void
    
    var body: some View {
        HStack {
            Button(action: onToggle) {
                Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(item.isChecked ? Theme.primary : .gray)
                    .font(.system(size: 22))
            }
            
            Text(item.label)
                .strikethrough(item.isChecked)
                .foregroundColor(item.isChecked ? .gray : .primary)
            
            Spacer()
        }
        .contentShape(Rectangle())
        .padding(.vertical, 8)
    }
}
