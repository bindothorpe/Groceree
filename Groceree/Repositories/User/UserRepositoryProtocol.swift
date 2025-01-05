//
//  UserRepositoryProtocol.swift
//  Groceree
//
//  Created by Bindo Thorpe on 17/12/2024.
//

import Foundation
import UIKit

protocol UserRepositoryProtocol {
    func fetchUser(id: String) async throws -> User
    func fetchCurrentUser() async throws -> User
    func updateUser(user: UpdateUserDTO) async throws -> User
    func uploadImage(_ image: UIImage) async throws
}
