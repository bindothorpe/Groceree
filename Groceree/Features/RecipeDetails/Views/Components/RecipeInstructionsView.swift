//
//  RecipeInstructionsView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 15/12/2024.
//

import SwiftUI

struct RecipeInstructionsView: View {
    let instructions: [Instruction]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("INSTRUCTIONS")
                .foregroundColor(.gray)
                .font(.system(size: 14))
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 16) {
                ForEach(instructions, id: \.self) { instruction in
                    HStack(alignment: .top, spacing: 8) {
                        Text("\(instruction.step).")
                        Text(instruction.instruction)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
                    .shadow(radius: 4)
            )
            .padding(.horizontal)
        }
    }
}
