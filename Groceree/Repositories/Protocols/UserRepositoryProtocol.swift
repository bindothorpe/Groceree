//
//  UserRepositoryProtocol.swift
//  Groceree
//
//  Created by Bindo Thorpe on 17/12/2024.
//

import Foundation

protocol UserRepositoryProtocol {
    func fetchUser(id: String) async throws -> User
}
