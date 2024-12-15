//
//  InstructionRowView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 15/12/2024.
//

import SwiftUI

struct InstructionRowView: View {
    @Binding var instruction: Instruction
    @FocusState private var isFocused: Bool
    let onDelete: () -> Void
    
    var body: some View {
        HStack {
            Text("\(instruction.step).")
                .foregroundColor(.gray)
                .frame(width: 30, alignment: .leading)
            
            TextField("Voeg een stap toe", text: $instruction.instruction)
                .focused($isFocused)
            
            Button(action: onDelete) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
            }
        }
    }
}
