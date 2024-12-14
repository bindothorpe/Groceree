//
//  RecipeListItem.swift
//  Groceree
//
//  Created by Bindo Thorpe on 14/12/2024.
//

import Foundation

struct RecipeListItem: Identifiable {
    let id: Int
    var name: String
    var imageUrl: String
    var duration: Int
    var isFavorite: Bool
    
    func formattedDuration() -> String {
        let hours = duration / 60
        let minutes = duration % 60
        
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else {
            return "\(minutes)m"
        }
    }
}
