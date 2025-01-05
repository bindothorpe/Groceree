//
//  KeychainManager.swift
//  Groceree
//
//  Created by Bindo Thorpe on 24/12/2024.
//

import Foundation
import Security

enum KeychainError: Error {
    case duplicateEntry
    case unknown(OSStatus)
    case itemNotFound
    case invalidItemFormat
}

class KeychainManager {
    static let shared = KeychainManager()

    private init() {}

    // MARK: - Save
    func save(_ data: Data, service: String, account: String) throws {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecValueData as String: data as AnyObject,
        ]

        let status = SecItemAdd(query as CFDictionary, nil)

        if status == errSecDuplicateItem {
            throw KeychainError.duplicateEntry
        }

        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }
    }

    // MARK: - Update
    func update(_ data: Data, service: String, account: String) throws {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
        ]

        let attributes: [String: AnyObject] = [
            kSecValueData as String: data as AnyObject
        ]

        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)

        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }

        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }
    }

    // MARK: - Get
    func get(service: String, account: String) throws -> Data {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne,
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }

        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }

        guard let data = result as? Data else {
            throw KeychainError.invalidItemFormat
        }

        return data
    }

    // MARK: - Delete
    func delete(service: String, account: String) throws {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
        ]

        let status = SecItemDelete(query as CFDictionary)

        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.unknown(status)
        }
    }

    // MARK: - Convenience Methods for Auth
    func saveToken(_ token: String) throws {
        guard let data = token.data(using: .utf8) else {
            throw KeychainError.invalidItemFormat
        }

        do {
            try save(data, service: "com.groceree.auth", account: "token")
        } catch KeychainError.duplicateEntry {
            try update(data, service: "com.groceree.auth", account: "token")
        }
    }

    func getToken() throws -> String {
        let data = try get(service: "com.groceree.auth", account: "token")
        guard let token = String(data: data, encoding: .utf8) else {
            throw KeychainError.invalidItemFormat
        }
        return token
    }

    func deleteToken() throws {
        try delete(service: "com.groceree.auth", account: "token")
    }

    func saveUsername(_ username: String) throws {
        guard let data = username.data(using: .utf8) else {
            throw KeychainError.invalidItemFormat
        }

        do {
            try save(data, service: "com.groceree.auth", account: "username")
        } catch KeychainError.duplicateEntry {
            try update(data, service: "com.groceree.auth", account: "username")
        }
    }

    func getUsername() throws -> String {
        let data = try get(service: "com.groceree.auth", account: "username")
        guard let username = String(data: data, encoding: .utf8) else {
            throw KeychainError.invalidItemFormat
        }
        return username
    }

    func deleteUsername() throws {
        try delete(service: "com.groceree.auth", account: "username")
    }
}
