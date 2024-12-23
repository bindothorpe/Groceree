//
//  APIRegisterRequest.swift
//  Groceree
//
//  Created by Bindo Thorpe on 23/12/2024.
//

struct APIRegisterRequest: Encodable {
    let firstName: String
    let lastName: String
    let username: String
    let password: String
}
