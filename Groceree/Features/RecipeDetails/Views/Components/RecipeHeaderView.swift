//
//  RecipeHeaderView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 15/12/2024.
//

import SwiftUI

struct RecipeHeaderView: View {
    let imageUrl: String
    let authorId: String
    let authorFirstName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .overlay(
                        ProgressView()
                    )
            }
            .frame(height: 250)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal)
            
            NavigationLink(destination: ProfileView(userId: authorId)) {
                Text("Geschreven door \(authorFirstName)")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
        .background(Color.white)
    }
}
