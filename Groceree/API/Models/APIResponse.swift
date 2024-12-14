//
//  APIResponse.swift
//  Groceree
//
//  Created by Bindo Thorpe on 13/12/2024.
//

import Foundation

struct APIResponse<T: Codable>: Codable {
    enum Status: String, Codable {
        case success
        case error
    }
    
    let status: Status
    let data: T
    let message: String?
    
    var isSuccess: Bool {
        return status == .success
    }
}
