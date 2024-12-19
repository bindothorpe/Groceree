//
//  GeneralSectionView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 15/12/2024.
//

import SwiftUI

struct GeneralSectionView: View {
    @Binding var name: String
    @Binding var hours: Int
    @Binding var minutes: Int
    @Binding var servings: Int
    
    var body: some View {
        Section("ALGEMEEN") {
            TextField("Naam", text: $name)
                .onChange(of: name) {
                    if name.count > 75 {
                        name = String(name.prefix(75))
                    }
                }
            
            Button(action: {
                // Add photo action
            }) {
                HStack {
                    Text("Foto")
                    Spacer()
                    Text("Voeg toe")
                        .foregroundColor(.gray)
                }
            }
            
            DatePicker(
                "Duratie",
                selection: Binding(
                    get: {
                        Calendar.current.date(from: DateComponents(hour: hours, minute: minutes)) ?? Date()
                    },
                    set: { newDate in
                        let components = Calendar.current.dateComponents([.hour, .minute], from: newDate)
                        hours = components.hour ?? 0
                        minutes = components.minute ?? 0
                    }
                ),
                displayedComponents: .hourAndMinute
            )
            
            HStack {
                Text("Porties")
                Spacer()
                Stepper(
                    value: $servings,
                    in: 1...20,
                    label: {
                        Text("\(servings)")
                            .foregroundColor(.gray)
                    }
                )
            }
        }
    }
}
