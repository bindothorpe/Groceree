//
//  RecipeListItem.swift
//  Groceree
//
//  Created by Bindo Thorpe on 13/12/2024.
//

struct RecipeListItem: Identifiable {
    let id: Int
    let name: String
    let imageUrl: String?
    let duration: Int
    
    var formattedDuration: String {
        let hours = duration / 60
        let minutes = duration % 60
        
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else {
            return "\(minutes)m"
        }
    }
}
