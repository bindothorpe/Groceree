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
    
    enum Field {
        case username
        case password
    }
    
    var body: some View {
        VStack(spacing: 24) {
            // Title
            Text("Welcome Back")
                .font(.title)
                .fontWeight(.bold)
            
            VStack(spacing: 16) {
                // Username field
                TextField("Username", text: $viewModel.username)
                    .textContentType(.username)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .username)
                    .submitLabel(.next)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                // Password field
                SecureField("Password", text: $viewModel.password)
                    .textContentType(.password)
                    .focused($focusedField, equals: .password)
                    .submitLabel(.go)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
            
            // Error message
            if let error = viewModel.error {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            // Login button
            Button(action: {
                Task {
                    await viewModel.login()
                    // After login attempt, check auth status
                    await authViewModel.checkAuthenticationStatus()
                }
            }) {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text("Login")
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(viewModel.isLoginButtonDisabled ? Color.gray : Theme.primary)
            .foregroundColor(.white)
            .cornerRadius(8)
            .disabled(viewModel.isLoginButtonDisabled)
            
            Spacer()
        }
        .padding()
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
