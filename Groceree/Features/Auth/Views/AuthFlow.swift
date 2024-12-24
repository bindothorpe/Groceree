//
//  AuthFlow.swift
//  Groceree
//
//  Created by Bindo Thorpe on 24/12/2024.
//

import SwiftUI

struct AuthFlow: View {
    var body: some View {
        NavigationStack {
            LoginView()
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
