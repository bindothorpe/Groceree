//
//  MeasurementUnit.swift
//  Groceree
//
//  Created by Bindo Thorpe on 14/12/2024.
//

enum MeasurementUnit: String, Codable, CaseIterable {
    case grams = "g"
    case kilograms = "kg"
    case milliliters = "ml"
    case liters = "l"
    case pieces = "pcs"
    case tablespoons = "tbsp"
    case teaspoons = "tsp"
    case cups = "cup"
    
    var displayName: String {
        switch self {
        case .grams: return "Grams"
        case .kilograms: return "Kilograms"
        case .milliliters: return "Milliliters"
        case .liters: return "Liters"
        case .pieces: return "Pieces"
        case .tablespoons: return "Tablespoons"
        case .teaspoons: return "Teaspoons"
        case .cups: return "Cups"
        }
    }
}
