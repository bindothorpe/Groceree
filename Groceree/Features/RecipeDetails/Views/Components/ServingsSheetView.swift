//
//  ServingsSheetView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 15/12/2024.
//

import SwiftUI

struct ServingsSheetView: View {
    @Binding var selectedServings: Int
    @Binding var isPresented: Bool
    let onConfirm: () -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Stepper(
                    value: $selectedServings,
                    in: 1...20
                ) {
                    HStack {
                        Text("Aantal porties")
                        Spacer()
                        Text("\(selectedServings)")
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Aantal porties")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuleer") {
                        isPresented = false
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Voeg toe") {
                        onConfirm()
                        isPresented = false
                    }
                }
            }
        }
        .presentationDetents([.height(180)])
    }
}
