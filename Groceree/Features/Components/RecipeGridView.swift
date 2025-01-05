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
    
    @Environment(\.horizontalSizeClass) private var sizeClass
    @State private var orientation = UIDevice.current.orientation
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(recipeListItems) { recipeListItem in
                RecipeCard(
                    recipeListItem: recipeListItem,
                    onFavoriteToggle: {
                        onFavoriteToggle(recipeListItem)
                    },
                    width: calculateItemWidth(),
                    height: 160
                )
            }
        }
        .padding(.horizontal)
        .onRotate { newOrientation in
            orientation = newOrientation
        }
    }
    
    private func calculateItemWidth() -> CGFloat {
        let spacing: CGFloat = 16
        let columnCount: Int = UIDevice.current.userInterfaceIdiom == .pad
            ? (sizeClass == .regular ? 3 : 4)
            : 2
            
        return (UIScreen.main.bounds.width - (CGFloat(columnCount - 1) * spacing) - (spacing * 2)) / CGFloat(columnCount)
    }

    private var columns: [GridItem] {
        let spacing: CGFloat = 16
        let columnCount: Int = UIDevice.current.userInterfaceIdiom == .pad
            ? (sizeClass == .regular ? 3 : 4)
            : 2
            
        return Array(repeating: GridItem(.fixed(calculateItemWidth()), spacing: spacing), count: columnCount)
    }
}

// View modifier to handle rotation
struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

// Extension to make the modifier easier to use
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
