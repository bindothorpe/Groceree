//
//  RecipeGridView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 19/12/2024.
//

import SwiftUI

struct RecipeGridView: View {
    let recipeListItems: [RecipeListItem]
    let onFavoriteToggle: (RecipeListItem) -> Void
    
    @State private var isPortrait = UIDevice.current.orientation.isPortrait
    
    private var gridLayout: [GridItem] {
        let idiom = UIDevice.current.userInterfaceIdiom
        let isPortrait = UIDevice.current.orientation.isPortrait
        
        switch idiom {
        case .pad:
            // iPad: 3 columns in portrait, 4 in landscape
            let columnCount = isPortrait ? 3 : 4
            return Array(repeating: GridItem(.fixed(UIScreen.main.bounds.width / CGFloat(columnCount) - 20)), count: columnCount)
        default:
            // iPhone: 2 columns
            return Array(repeating: GridItem(.fixed(UIScreen.main.bounds.width / 2 - 20)), count: 2)
        }
    }
    
    var body: some View {
        LazyVGrid(columns: gridLayout, spacing: 16) {
            ForEach(recipeListItems) { recipeListItem in
                RecipeCard(
                    recipeListItem: recipeListItem,
                    onFavoriteToggle: {
                        onFavoriteToggle(recipeListItem)
                    }
                )
            }
        }
        .padding(.horizontal)
        .onAppear {
            NotificationCenter.default.addObserver(
                forName: UIDevice.orientationDidChangeNotification,
                object: nil,
                queue: .main) { _ in
                    isPortrait = UIDevice.current.orientation.isPortrait
            }
        }
    }
}
