//
//  RecipeGeneralInfoView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 15/12/2024.
//

import SwiftUI

struct RecipeGeneralInfoView: View {
    let servings: Int
    let duration: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("ALGEMEEN")
                .foregroundColor(.gray)
                .font(.system(size: 14))
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Porties")
                    Spacer()
                    Text("\(servings)")
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Text("Duratie")
                    Spacer()
                    Text(duration)
                        .foregroundColor(.gray)
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
