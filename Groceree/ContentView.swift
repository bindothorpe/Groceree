//
//  ContentView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationBar()
            .background(Theme.background)
    }
}

#Preview {
    let mockApi = MockGrocereeAPI()
    let environment = APIEnvironment(api: mockApi)
    
    return ContentView()
        .environmentObject(environment)
}
