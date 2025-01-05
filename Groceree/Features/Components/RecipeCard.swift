//
//  RecipeCard.swift
//  Groceree
//
//  Created by Bindo Thorpe on 02/12/2024.
//

import SwiftUI
import asnycImage

struct RecipeCard: View {
    let recipeListItem: RecipeListItem
    let onFavoriteToggle: () -> Void
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        NavigationLink(destination: RecipeDetailView(recipeId: recipeListItem.id)) {
            VStack(spacing: 0) {
                ZStack(alignment: .topTrailing) {
                    CAsyncImage(urlString: recipeListItem.imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: width, height: height)
                            .clipped()
                    } placeholder: {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: width, height: height)
                            .overlay(
                                ProgressView()
                            )
                    }
                    .clipShape(
                        RoundedCorner(radius: 12, corners: [.topLeft, .topRight])
                    )
                    
                    // Heart Button
                    Button(action: {
                        onFavoriteToggle()
                    }) {
                        Image(systemName: recipeListItem.isFavorite ? "heart.fill" : "heart")
                            .font(.system(size: 20))
                            .foregroundColor(Theme.primary)
                            .padding(8)
                            .background(
                                Circle()
                                    .fill(.white.opacity(0.8))
                                    .shadow(radius: 2)
                            )
                    }
                    .padding(8)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(recipeListItem.name)
                        .font(.system(size: 16, weight: .bold))
                        .lineLimit(1)
                    
                    Text(recipeListItem.formattedDuration())
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(12)
            }
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
                    .shadow(radius: 4)
            )
            .frame(maxWidth: .infinity)
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
