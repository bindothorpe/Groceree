//
//  User.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    var firstName: String
    var lastName: String
    var imageUrl: String
    var bio: String
}
