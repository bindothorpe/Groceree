//
//  MockUserRepository.swift
//  Groceree
//
//  Created by Bindo Thorpe on 19/12/2024.
//

class MockUserRepository: UserRepositoryProtocol {
       
    private var users: [User] = [
        User(
            id: "1234",
            firstName: "John",
            lastName: "Doe",
            imageUrl: "https://example.com/image.jpg",
            bio: "Example of a user bio"
        ),
        User(
            id: "5678",
            firstName: "Mirthe",
            lastName: "Baecke",
            imageUrl: "https://example.com/image.jpg",
            bio: "Example of a user bio"
        )
        
    ]
    
    
    func fetchUser(id: String) async throws -> User {
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        guard let user = users.first(where: { $0.id == id }) else {
            throw UserError.notFound
        }
        return user
    }
    
    func fetchCurrentUser() async throws -> User {
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        guard let user = users.first(where: { $0.id == "1234" }) else {
            throw UserError.notFound
        }
        return user
    }
}
