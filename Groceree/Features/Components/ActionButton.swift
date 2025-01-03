//
//  ActionButton.swift
//  Groceree
//
//  Created by Bindo Thorpe on 03/01/2025.
//

import SwiftUI

struct ActionButton<Label: View>: View {
    let action: () async -> Void
    let label: () -> Label
    let isValid: Bool
    let isLoading: Bool
    
    init(
        isValid: Bool = true,
        isLoading: Bool = false,
        action: @escaping () async -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.action = action
        self.label = label
        self.isValid = isValid
        self.isLoading = isLoading
    }
    
    var body: some View {
        Button(action: {
            if !isLoading {
                Task {
                    await action()
                }
            }
            
        }) {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            } else {
                label()
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(isValid ? Theme.primary : Color.gray)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .disabled(!isValid || isLoading)
    }
}
