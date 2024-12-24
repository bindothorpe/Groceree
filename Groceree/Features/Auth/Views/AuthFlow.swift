//
//  AuthFlow.swift
//  Groceree
//
//  Created by Bindo Thorpe on 24/12/2024.
//

import SwiftUI

struct AuthFlow: View {
    @State private var showingRegister = false

    var body: some View {
        NavigationStack {
            LoginView()
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Don't have an account? Register") {
                            showingRegister = true
                        }
                        .foregroundColor(Theme.primary)
                    }
                }
                .sheet(isPresented: $showingRegister) {
                    NavigationStack {
                        RegisterView()
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("Cancel") {
                                        showingRegister = false
                                    }
                                }
                            }
                    }
                }
        }
    }
}
