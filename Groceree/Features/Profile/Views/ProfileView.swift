//
//  ProfileView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel: ProfileViewModel
    
    init(userId: String) {
        _viewModel = StateObject(wrappedValue: ProfileViewModel(userId: userId))
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else if let user = viewModel.user {
                NavigationStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("PERSOONLIJKE INFORMATIE")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                            
                            VStack(alignment: .leading, spacing: 24) {
                                HStack(spacing: 16) {
                                    AsyncImage(url: URL(string: user.imageUrl ?? "")) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } placeholder: {
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .foregroundColor(.gray.opacity(0.3))
                                    }
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                    
                                    Text(user.firstName)
                                        .font(.title3)
                                    
                                    Spacer()
                                }
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(user.bio ?? "")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white)
                                    .shadow(radius: 9)
                            )
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                    }
                    .navigationTitle(TabItem.profile.title)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            HStack {
                                Button(action: {}) {
                                    Image(systemName: "bell")
                                        .foregroundColor(Theme.primary)
                                }
                                Button(action: {}) {
                                    Image(systemName: "ellipsis")
                                        .foregroundColor(Theme.primary)
                                }
                            }
                        }
                    }
                }
            } else if let error = viewModel.error {
                ContentUnavailableView(
                    "Error",
                    systemImage: "exclamationmark.triangle",
                    description: Text(error)
                )
            } else {
                ContentUnavailableView(
                    "Profile not found",
                    systemImage: "questionmark.circle"
                )
            }
        }
        .task {
            await viewModel.fetchUser()
        }
    }
}
