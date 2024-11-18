//
//  ProfileViewModel.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var userData: User?
        
        func fetchUserData() { //TODO: Implement real data fetching
            // Simulate fetching user data
            userData = User(
                id: "1",
                username: "TestUser",
                avatarUrl: "placeholder",
                bio: "Hello, I'm using Groceree!",
                recipeIds: [],
                likedRecipeIds: []
            )
        }
}
