//
//  UpdateUserViewModel.swift
//  Groceree
//
//  Created by Bindo Thorpe on 02/01/2025.
//

import SwiftUI

@MainActor
class UpdateUserViewModel: ObservableObject {
    @Published var firstName: String
    @Published var lastName: String
    @Published var bio: String
    @Published var selectedImage: UIImage?
    @Published var currentImageUrl: String
    
    @Published var isLoading = false
    @Published var error: String?
    
    private let userRepository: UserRepositoryProtocol
    private let user: User
    private var onUpdateSuccess: () -> Void
    
    init(
        user: User,
        userRepository: UserRepositoryProtocol = ServiceContainer.shared.userRepository,
        onUpdateSuccess: @escaping () -> Void
    ) {
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.bio = user.bio
        self.user = user
        self.userRepository = userRepository
        self.onUpdateSuccess = onUpdateSuccess
        self.currentImageUrl = user.imageUrl
    }
    
    var isValid: Bool {
        !firstName.isEmpty &&
        !lastName.isEmpty &&
        !bio.isEmpty &&
        (firstName != user.firstName ||
         lastName != user.lastName ||
         bio != user.bio ||
         selectedImage != nil)
    }
    
    func updateUser() async {
        isLoading = true
        error = nil
        
        do {
            // If there's a new image, upload it first
            if let image = selectedImage {
                try await userRepository.uploadImage(image)
            }
            
            let updateUserDTO = UpdateUserDTO(
                firstName: firstName,
                lastName: lastName,
                bio: bio
            )
            let _ = try await userRepository.updateUser(user: updateUserDTO)
            onUpdateSuccess()
        } catch {
            self.error = error.localizedDescription
        }
        
        isLoading = false
    }
}
