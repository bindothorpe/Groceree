//
//  RegisterView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 24/12/2024.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()
    @EnvironmentObject private var authViewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: Field?
    
    enum Field {
        case firstName
        case lastName
        case username
        case password
        case confirmPassword
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Create Account")
                    .font(.title)
                    .fontWeight(.bold)
                
                VStack(spacing: 16) {
                    TextField("First Name", text: $viewModel.firstName)
                        .textContentType(.givenName)
                        .focused($focusedField, equals: .firstName)
                        .submitLabel(.next)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    TextField("Last Name", text: $viewModel.lastName)
                        .textContentType(.familyName)
                        .focused($focusedField, equals: .lastName)
                        .submitLabel(.next)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    TextField("Username", text: $viewModel.username)
                        .textContentType(.username)
                        .textInputAutocapitalization(.never)
                        .focused($focusedField, equals: .username)
                        .submitLabel(.next)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .onChange(of: viewModel.username) { _ in
                            Task {
                                await viewModel.checkUsernameAvailability()
                            }
                        }
                    
                    SecureField("Password", text: $viewModel.password)
                        .textContentType(.newPassword)
                        .focused($focusedField, equals: .password)
                        .submitLabel(.next)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    SecureField("Confirm Password", text: $viewModel.confirmPassword)
                        .textContentType(.newPassword)
                        .focused($focusedField, equals: .confirmPassword)
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
                        await viewModel.register()
                        await authViewModel.checkAuthenticationStatus()
                    }
                }) {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("Create Account")
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(viewModel.isRegisterButtonDisabled ? Color.gray : Theme.primary)
                .foregroundColor(.white)
                .cornerRadius(8)
                .disabled(viewModel.isRegisterButtonDisabled)
                
                Button("Already have an account? Login") {
                    dismiss()
                }
                .foregroundColor(Theme.primary)
            }
            .padding()
        }
        .onSubmit {
            switch focusedField {
            case .firstName:
                focusedField = .lastName
            case .lastName:
                focusedField = .username
            case .username:
                focusedField = .password
            case .password:
                focusedField = .confirmPassword
            case .confirmPassword:
                Task {
                    await viewModel.register()
                    await authViewModel.checkAuthenticationStatus()
                }
            case .none:
                break
            }
        }
    }
}
