//
//  AuthRepositoryProtocol.swift
//  Groceree
//
//  Created by Bindo Thorpe on 23/12/2024.
//

protocol AuthRepositoryProtocol {
    func login(username: String, password: String) async throws -> String
    func register(firstName: String, lastName: String, username: String, password: String) async throws -> String
    func checkUsernameAvailability(username: String) async throws -> Bool
}
