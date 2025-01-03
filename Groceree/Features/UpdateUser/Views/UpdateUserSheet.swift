//
//  UpdateUserSheet.swift
//  Groceree
//
//  Created by Bindo Thorpe on 02/01/2025.
//

import SwiftUI

struct UpdateUserSheet: View {
    @StateObject private var viewModel: UpdateUserViewModel
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: Field?
    
    enum Field {
        case firstName
        case lastName
        case bio
    }
    
    init(user: User, onUpdateSuccess: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: UpdateUserViewModel(
            user: user,
            onUpdateSuccess: onUpdateSuccess
        ))
    }
    
    var body: some View {
        ZStack {
            NavigationStack {
                Form {
                    Section("PERSOONLIJKE INFORMATIE") {
                        TextField("Voornaam", text: $viewModel.firstName)
                            .focused($focusedField, equals: .firstName)
                            .textContentType(.givenName)
                            .submitLabel(.next)
                        
                        TextField("Achternaam", text: $viewModel.lastName)
                            .focused($focusedField, equals: .lastName)
                            .textContentType(.familyName)
                            .submitLabel(.next)
                        
                        TextField("Bio", text: $viewModel.bio, axis: .vertical)
                            .focused($focusedField, equals: .bio)
                            .submitLabel(.done)
                            .lineLimit(3...6)
                    }
                    
                    if let error = viewModel.error {
                        Section {
                            Text(error)
                                .foregroundColor(.red)
                        }
                    }
                }
                .navigationTitle("Edit Profile")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                        .foregroundColor(Theme.primary)
                    }
                    
                    ToolbarItem(placement: .bottomBar) {
                        ActionButton(
                            isValid: viewModel.isValid,
                            isLoading: viewModel.isLoading
                        ) {
                            await viewModel.updateUser()
                            dismiss()
                        } label: {
                            Text("Save")
                        }
                        .padding()
                    }
                }
                .onSubmit {
                    switch focusedField {
                    case .firstName:
                        focusedField = .lastName
                    case .lastName:
                        focusedField = .bio
                    case .bio:
                        Task {
                            await viewModel.updateUser()
                            dismiss()
                        }
                    case .none:
                        break
                    }
                }
            }
            .interactiveDismissDisabled(viewModel.isLoading)
            .disabled(viewModel.isLoading)
            
            if viewModel.isLoading {
                LoadingOverlay()
            }
        }
    }
}
