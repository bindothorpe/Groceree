//
//  InstructionsSectionView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 15/12/2024.
//

import SwiftUI

struct InstructionsSectionView: View {
    @Binding var instructions: [Instruction]
    let onDelete: (String) -> Void
    let onAdd: () -> Void
    
    var body: some View {
        Section("INSTRUCTIONS") {
            ForEach($instructions) { $instruction in
                InstructionRowView(
                    instruction: $instruction,
                    onDelete: { onDelete(instruction.id) }
                )
            }
            
            Button("Add instruction") {
                onAdd()
            }
            .foregroundColor(Theme.primary)
        }
    }
}
