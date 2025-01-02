//
//  IngredientRowView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 15/12/2024.
//

import SwiftUI

struct IngredientRowView: View {
    @Binding var ingredient: Ingredient
    @FocusState private var focusedField: Field?
    let onDelete: () -> Void
    
    enum Field {
        case name
        case amount
    }
    
    var body: some View {
        HStack {
            // Ingredient name
            TextField("Ingredient", text: $ingredient.name)
                .focused($focusedField, equals: .name)
            
            // Amount
            TextField("Amount", value: $ingredient.amount, format: .number)
                .keyboardType(.numberPad)
                .frame(width: 40)
                .multilineTextAlignment(.trailing)
                .focused($focusedField, equals: .amount)
            
            // Unit picker with constrained size
            Menu {
                Picker("", selection: $ingredient.unit) {
                    ForEach(MeasurementUnit.allCases, id: \.self) { unit in
                        Text(unit.rawValue).tag(unit)
                    }
                }
            } label: {
                Text(ingredient.unit.rawValue)
                    .foregroundColor(Theme.primary)
                    .frame(width: 60)
            }
            
            // Delete button
            Button(action: onDelete) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .font(.system(size: 20))
            }
            .padding(.leading, 8)
        }
    }
}
