//
//  ContentView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        Group {
            if authViewModel.isCheckingAuth {
                // Show loading screen while checking auth status
                ProgressView()
            } else if authViewModel.isAuthenticated {
                // Show main app content
                NavigationBar()
                    .background(Theme.background)
                    .environmentObject(authViewModel)
            } else {
                // Show auth flow (login/register)
                LoginView()
                    .environmentObject(authViewModel)
            }
        }
        
    }
}

#Preview {
    ContentView()
}
