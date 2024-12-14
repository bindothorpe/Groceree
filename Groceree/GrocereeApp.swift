//
//  GrocereeApp.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//

import SwiftUI

@main
struct GrocereeApp: App {
    @StateObject private var environment: APIEnvironment
    
    init() {
        let api = MockGrocereeAPI()
        _environment = StateObject(wrappedValue: APIEnvironment(api: api))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(environment)
        }
    }
}
