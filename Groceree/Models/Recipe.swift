//
//  Recipe.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//
import Foundation

struct Recipe: Identifiable, Decodable {
    var id: String //TODO: Change this back to a let once I have the real API set up
    var author: Author
    var name: String
    var imageUrl: String
    var duration: Int
    var servings: Int
    var ingredients: [Ingredient]
    var instructions: [Instruction]
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
