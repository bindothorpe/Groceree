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
            VStack(spacing: 0) {
                ZStack(alignment: .topTrailing) {
                    // Image
                    AsyncImage(url: URL(string: recipeListItem.imageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width/2 - 24, height: 200)
                            .clipped()
                            .clipShape(
                                RoundedCorner(radius: 12, corners: [.topLeft, .topRight])
                            )
                    } placeholder: {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .overlay(
                                ProgressView()
                            )
                            .frame(width: UIScreen.main.bounds.width/2 - 24, height: 200)
                            .clipShape(
                                RoundedCorner(radius: 12, corners: [.topLeft, .topRight])
                            )
                    }
                    
                    // Heart Button
                    Button(action: {
                        onFavoriteToggle()
                    }) {
                        Image(systemName: recipeListItem.isFavorite ? "heart.fill" : "heart")
                            .font(.system(size: 24))
                            .foregroundColor(Theme.primary)
                            .padding(12)
                            .background(
                                Circle()
                                    .fill(.white.opacity(0.8))
                                    .shadow(radius: 2)
                            )
                    }
                    .padding(8)
                }
                .frame(width: UIScreen.main.bounds.width/2 - 24, height: 200)
                
                HStack {
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
            .frame(width: UIScreen.main.bounds.width/2 - 24)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
                    .shadow(radius: 4)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// Helper struct to create rounded corners for specific corners
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// Preview provider for SwiftUI canvas
#Preview {
    RecipeCard(
        recipeListItem: RecipeListItem(
            id: "1234",
            name: "Pasta Carbonara",
            imageUrl: "https://example.com/carbonara.jpg",
            duration: 30,
            isFavorite: false
        ),
        onFavoriteToggle: {}
    )
    .frame(width: 300)
}
