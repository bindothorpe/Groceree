//
//  RecipeCard.swift
//  Groceree
//
//  Created by Bindo Thorpe on 02/12/2024.
//

import SwiftUI

struct RecipeCard: View {
    let recipe: Recipe
    let onFavoriteToggle: () -> Void
    
    private var formattedDuration: String {
        let hours = recipe.duration / 60
        let minutes = recipe.duration % 60
        
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else {
            return "\(minutes)m"
        }
    }
    
    var body: some View {
        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
            ZStack {
                // Main card background
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
                    .shadow(radius: 4)
                
                VStack(spacing: 0) {
                    // Recipe image with heart overlay
                    ZStack(alignment: .topTrailing) {
                        AsyncImage(url: URL(string: recipe.imageUrl)) { image in
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
                            Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
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
                            Text(recipe.name)
                                .font(.system(size: 24, weight: .bold))
                                .lineLimit(1)
                            
                            Text(formattedDuration)
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
        recipe: Recipe(
            id: "1",
            name: "Pasta Carbonara",
            imageUrl: "https://example.com/carbonara.jpg",
            preparation: "Cook pasta...",
            duration: 30,
            portionAmount: 2,
            ingredientIds: ["1", "2", "3"],
            isFavorite: false
        ),
        onFavoriteToggle: {}
    )
    .frame(width: 300, height: 280)
}
