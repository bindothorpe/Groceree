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
            TextField("Ingredient", text: $ingredient.name)
                .focused($focusedField, equals: .name)
            
            TextField("Amount", value: $ingredient.amount, format: .number)
                .keyboardType(.numberPad)
                .frame(width: 60)
                .multilineTextAlignment(.trailing)
                .focused($focusedField, equals: .amount)
            
            Picker("", selection: $ingredient.unit) {
                ForEach(MeasurementUnit.allCases, id: \.self) { unit in
                    Text(unit.displayName).tag(unit)
                }
            }
            .frame(width: 100)
            
            Button(action: onDelete) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
            }
        }
    }
}
