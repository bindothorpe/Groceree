//
//  Recipe.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//
import Foundation

struct Recipe: Identifiable {
    let id: Int
    var name: String
    var imageUrl: String
    var duration: Int
    var servings: Int
    var isFavorite: Bool
    var ingredients: [Ingredient]
    var instructions: [Instruction]
    
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

