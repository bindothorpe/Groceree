//
//  LoginView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 24/12/2024.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject private var authViewModel: AuthViewModel
    @FocusState private var focusedField: Field?
    @State private var showingRegister = false
    
    enum Field {
        case username, password
    }
    
    var body: some View {
        VStack(spacing: 24) {
            
            Text("groceree")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Theme.primary)
            
            Text("Welcome Back")
                .font(.title)
                .fontWeight(.bold)
            
            VStack(spacing: 16) {
                TextField("Username", text: $viewModel.username)
                    .textContentType(.username)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .username)
                    .submitLabel(.next)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                SecureField("Password", text: $viewModel.password)
                    .textContentType(.password)
                    .focused($focusedField, equals: .password)
                    .submitLabel(.go)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
            
            if let error = viewModel.error {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            ActionButton(isValid: !viewModel.isLoginButtonDisabled, isLoading: viewModel.isLoading) {
                await viewModel.login()
                await authViewModel.checkAuthenticationStatus()
            } label: {
                Text("Login")
            }
            
            Button("Don't have an account? Register") {
                showingRegister = true
            }
            .foregroundColor(Theme.primary)
            
            Spacer()
                    .frame(height: 100)
        }
        .padding()
        .frame(maxWidth: 600)
        .frame(maxWidth: .infinity)
        .sheet(isPresented: $showingRegister) {
            NavigationStack {
                RegisterView()
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                showingRegister = false
                            }.foregroundColor(Theme.primary)
                        }
                    }
            }
        }
        .onSubmit {
            switch focusedField {
            case .username:
                focusedField = .password
            case .password:
                Task {
                    await viewModel.login()
                    await authViewModel.checkAuthenticationStatus()
                }
            case .none:
                break
            }
        }
    }
}
