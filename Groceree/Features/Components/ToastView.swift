//
//  ToastView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 03/01/2025.
//

import SwiftUI

struct ToastStyle {
    let backgroundColor: Color
    let foregroundColor: Color
    
    static let success = ToastStyle(
        backgroundColor: Theme.primary,
        foregroundColor: .white
    )
    
    static let error = ToastStyle(
        backgroundColor: Theme.secondaryDarken,
        foregroundColor: .white
    )
    
    static let info = ToastStyle(
        backgroundColor: Color.gray,
        foregroundColor: .white
    )
}

struct ToastView<Content: View>: View {
    let content: Content
    let style: ToastStyle
    @Binding var isPresented: Bool
    var duration: TimeInterval = 2
    
    init(style: ToastStyle, isPresented: Binding<Bool>, duration: TimeInterval = 2, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.style = style
        self._isPresented = isPresented
        self.duration = duration
    }
    
    var body: some View {
        content
            .foregroundColor(style.foregroundColor)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(style.backgroundColor)
            .clipShape(Capsule())
            .shadow(color: Color.black.opacity(0.16), radius: 4, x: 0, y: 2)
            .padding(.bottom, 32)
            .transition(.move(edge: .bottom).combined(with: .opacity))
            .animation(.spring(), value: isPresented)
            .onAppear {
                // Auto-dismiss after duration
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    withAnimation {
                        isPresented = false
                    }
                }
            }
    }
}
