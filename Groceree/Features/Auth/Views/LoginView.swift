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
            
            Button(action: {
                Task {
                    await viewModel.login()
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
            .buttonStyle(FilledButtonStyle())
            .disabled(viewModel.isLoginButtonDisabled)
            
            Button("Don't have an account? Register") {
                showingRegister = true
            }
            .foregroundColor(Theme.primary)
            
            Spacer()
                    .frame(height: 100)
        }
        .padding()
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

struct FilledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(configuration.isPressed ? Theme.primary.opacity(0.8) : Theme.primary)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}
