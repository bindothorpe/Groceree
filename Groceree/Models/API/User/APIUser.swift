//
//  APIUser.swift
//  Groceree
//
//  Created by Bindo Thorpe on 04/01/2025.
//

import Foundation

struct APIUser: Decodable {
    let id: String
    var firstName: String
    var lastName: String
    var imageUrl: String
    var bio: String
    
    func toUser() -> User {
        User(
            id: id,
            firstName: firstName,
            lastName: lastName,
            imageUrl: "\(APIConstants.baseImageURL)\(imageUrl)",
            bio: bio
        )
    }
}


