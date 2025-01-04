//
//  View+Extensions.swift
//  Groceree
//
//  Created by Bindo Thorpe on 03/01/2025.
//

import SwiftUI

extension View {
    func toast<Content: View>(
        style: ToastStyle = .success,
        isPresented: Binding<Bool>,
        duration: TimeInterval = 2,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.overlay(alignment: .bottom) {
            if isPresented.wrappedValue {
                ToastView(
                    style: style,
                    isPresented: isPresented,
                    duration: duration,
                    content: content
                )
            }
        }
    }
    
    // Convenience method for simple text toasts
    func toast(
        message: String,
        style: ToastStyle = .success,
        isPresented: Binding<Bool>,
        duration: TimeInterval = 2
    ) -> some View {
        self.toast(
            style: style,
            isPresented: isPresented,
            duration: duration
        ) {
            Text(message)
        }
    }
}
