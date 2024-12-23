//
//  UsernameAvailabilityResponse.swift
//  Groceree
//
//  Created by Bindo Thorpe on 23/12/2024.
//

struct UsernameAvailabilityResponse: Decodable {
    let available: Bool
    let username: String
    let message: String
}
