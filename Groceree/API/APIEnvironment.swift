//
//  APIEnvironment.swift
//  Groceree
//
//  Created by Bindo Thorpe on 13/12/2024.
//

import Foundation

class APIEnvironment: ObservableObject {
    let api: GrocereeAPIProtocol
    
    init(api: GrocereeAPIProtocol) {
        self.api = api
    }
}
