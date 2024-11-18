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
            Text("Profiel")
                .navigationTitle(TabItem.profile.title)
        }
        .onAppear {
            viewModel.fetchUserData()
        }
    }
}
