//
//  ProfileImagePicker.swift
//  Groceree
//
//  Created by Bindo Thorpe on 04/01/2025.
//

import SwiftUI
import PhotosUI

struct ProfileImagePicker: View {
    let currentImageUrl: String
    @Binding var selectedImage: UIImage?
    @State private var imageSelection: PhotosPickerItem?
    @State private var isImageLoading = false
    
    var body: some View {
        PhotosPicker(selection: $imageSelection,
                    matching: .images,
                    photoLibrary: .shared()) {
            ZStack {
                // Current or Selected Image
                Group {
                    if let selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        AsyncImage(url: URL(string: currentImageUrl)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .foregroundColor(.gray.opacity(0.3))
                        }
                    }
                }
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                
                // Overlay
                Circle()
                    .fill(Color.black.opacity(0.3))
                    .frame(width: 100, height: 100)
                
                // Camera Icon
                Image(systemName: "camera.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                
                if isImageLoading {
                    ProgressView()
                        .frame(width: 100, height: 100)
                        .background(Color.black.opacity(0.3))
                        .clipShape(Circle())
                }
            }
        }
        .onChange(of: imageSelection) { oldItem, newItem in
            guard let item = newItem else { return }
            isImageLoading = true
            
            Task {
                if let data = try? await item.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    await MainActor.run {
                        selectedImage = uiImage
                        isImageLoading = false
                    }
                } else {
                    print("Failed to load image")
                    isImageLoading = false
                }
            }
        }
    }
}
