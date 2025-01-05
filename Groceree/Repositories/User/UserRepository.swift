//
//  UserRepository.swift
//  Groceree
//
//  Created by Bindo Thorpe on 24/12/2024.
//

import Foundation
import UIKit

class UserRepository: UserRepositoryProtocol {
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func fetchUser(id: String) async throws -> User {
        let response: APIUserResponse = try await apiClient.fetch("/api/users/\(id)")
        return response.user.toUser()
    }

    func fetchCurrentUser() async throws -> User {
        let response: APIUserResponse = try await apiClient.fetch("/api/users/me")
        return response.user.toUser()
    }

    func updateUser(user: UpdateUserDTO) async throws -> User {
        let response: APIUserResponse = try await apiClient.fetch(
            "/api/users", method: "PUT", body: user)
        return response.user.toUser()
    }

    func uploadImage(_ image: UIImage) async throws {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw APIError.invalidRequest
        }

        guard imageData.count <= 5_242_880 else {
            throw APIError.invalidRequest
        }

        let boundary = UUID().uuidString

        guard let url = URL(string: "\(APIConstants.baseURL)/api/users/image") else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        if let token = try? KeychainManager.shared.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        request.setValue(
            "multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()

        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append(
            "Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(
                using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        request.httpBody = body

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.networkError(NSError(domain: "", code: -1))
            }

            switch httpResponse.statusCode {
            case 200...299:
                if let decodedResponse = try? JSONDecoder().decode(APIResponse.self, from: data) {
                    if decodedResponse.success == true {
                        return
                    }
                }
                throw APIError.serverError("Upload failed")

            case 400:
                throw APIError.invalidRequest
            case 401:
                throw APIError.unauthorized
            case 404:
                throw APIError.notFound
            default:
                if let errorResponse = try? JSONDecoder().decode(APIErrorResponse.self, from: data)
                {
                    throw APIError.serverError(errorResponse.error)
                }
                throw APIError.serverError(
                    "Upload failed with status code: \(httpResponse.statusCode)")
            }
        } catch {
            if let apiError = error as? APIError {
                throw apiError
            }
            throw APIError.networkError(error)
        }
    }
}
