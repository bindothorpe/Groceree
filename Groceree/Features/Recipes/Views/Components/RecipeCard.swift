//
//  RecipeCard.swift
//  Groceree
//
//  Created by Bindo Thorpe on 02/12/2024.
//

import SwiftUI

struct RecipeCard: View {
    let recipeListItem: RecipeListItem
    let onFavoriteToggle: () -> Void
    
    var body: some View {
        NavigationLink(destination: RecipeDetailView(recipeId: recipeListItem.id)) {
            ZStack {
                // Main card background
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
                    .shadow(radius: 4)
                
                VStack(spacing: 0) {
                    // Recipe image with heart overlay
                    ZStack(alignment: .topTrailing) {
                        AsyncImage(url: URL(string: recipeListItem.imageUrl)) { image in
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
                        
                        // Heart icon
                        Button(action: {
                            // Prevent navigation when tapping the heart
                            onFavoriteToggle()
                        }) {
                            Image(systemName: recipeListItem.isFavorite ? "heart.fill" : "heart")
                                .font(.system(size: 24))
                                .foregroundColor(Theme.primary)
                                .padding(12)
                        }
                    }
                    .frame(height: 200)
                    .clipped()
                    
                    // Recipe info container
                    HStack {
                        // Recipe name and time
                        VStack(alignment: .leading, spacing: 4) {
                            Text(recipeListItem.name)
                                .font(.system(size: 24, weight: .bold))
                                .lineLimit(1)
                            
                            Text(recipeListItem.formattedDuration())
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }
                    .padding()
                }
            }
        }
        // This prevents the NavigationLink from showing the blue color when tapped
        .buttonStyle(PlainButtonStyle())
    }
}

// Preview provider for SwiftUI canvas
#Preview {
    RecipeCard(
        recipeListItem: RecipeListItem(
            id: 1,
            name: "Pasta Carbonara",
            imageUrl: "https://example.com/carbonara.jpg",
            duration: 30,
            isFavorite: false
        ),
        onFavoriteToggle: {}
    )
    .frame(width: 300, height: 280)
}

