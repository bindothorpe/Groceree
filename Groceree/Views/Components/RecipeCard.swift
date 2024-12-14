//
//  RecipeCard.swift
//  Groceree
//
//  Created by Bindo Thorpe on 02/12/2024.
//

import SwiftUI

struct RecipeCard: View {
    let recipe: RecipeListItem
    let onFavoriteToggle: () -> Void
    
    var body: some View {
        NavigationLink(destination: RecipeDetailView(recipeId: recipe.id)) {
            ZStack {
                // Main card background
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
                    .shadow(radius: 4)
                
                VStack(spacing: 0) {
                    // Recipe image with heart overlay
                    ZStack(alignment: .topTrailing) {
                        if let imageUrl = recipe.imageUrl {
                            AsyncImage(url: URL(string: imageUrl)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width / 2 - 24, height: 200)
                            } placeholder: {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 200)
                            }
                        } else {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 200)
                        }
                        
                        // Heart icon
                        Button(action: onFavoriteToggle) {
                            Image(systemName: "heart")
                                .font(.system(size: 24))
                                .foregroundColor(Theme.primary)
                                .padding(12)
                        }
                    }
                    .frame(height: 200)
                    .clipShape(
                        UnevenRoundedRectangle(
                            cornerRadii: RectangleCornerRadii(
                                topLeading: 12,
                                bottomLeading: 0,
                                bottomTrailing: 0,
                                topTrailing: 12
                            )
                        )
                    )
                    
                    // Recipe info container
                    HStack {
                        // Recipe name and time
                        VStack(alignment: .leading, spacing: 4) {
                            Text(recipe.name)
                                .font(.system(size: 24, weight: .bold))
                                .lineLimit(1)
                            
                            Text(recipe.formattedDuration)
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }
                    .padding()
                }
            }
        }
    }
}
