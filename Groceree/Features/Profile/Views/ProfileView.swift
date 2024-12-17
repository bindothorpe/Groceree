//
//  ProfileView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 18/11/2024.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                if let user = viewModel.userData {
                    Section("PERSONAL INFORMATION") {
                        VStack(alignment: .leading) {
                            HStack(alignment: .top) {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.gray)
                                    .padding()
                                
                                // User Name
                                Text("\(user.firstName) \(user.lastName)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.leading)
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Bio")
                                    .font(.headline)
                                Text(user.bio)
                                    .multilineTextAlignment(.leading)
                            }
                            .padding(.top)
                        }
                    }
                } else {
                    ProgressView()
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle(TabItem.profile.title)
        }
        .onAppear {
            viewModel.fetchUserData()
        }
    }
}
