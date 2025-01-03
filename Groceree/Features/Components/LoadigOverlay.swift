//
//  LoadigOverlay.swift
//  Groceree
//
//  Created by Bindo Thorpe on 03/01/2025.
//

import SwiftUI

struct LoadingOverlay: View {
    
    let showLoadingIndicator: Bool
    let showDarkOverlay: Bool
    
    init(
        showLoadingIndicator: Bool = false,
        showDarkOverlay: Bool = true
    ) {
        self.showLoadingIndicator = showLoadingIndicator
        self.showDarkOverlay = showDarkOverlay
    }
    
    var body: some View {
        ZStack {
            if showDarkOverlay {
                Color.black
                    .opacity(0.1)
                    .ignoresSafeArea()
            }
            
            if showLoadingIndicator {
                ProgressView()
                    .controlSize(.large)
                    .tint(.white)
            }
        }
        .allowsHitTesting(true)
    }
}
