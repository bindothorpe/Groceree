//
//  GeneralSectionView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 15/12/2024.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct GeneralSectionView: View {
    @Binding var name: String
    @Binding var hours: Int
    @Binding var minutes: Int
    @Binding var servings: Int
    @State private var imageSelection: PhotosPickerItem? = nil
    @Binding var selectedImage: UIImage?
    @State private var isImageLoading = false

    var body: some View {
        Section("GENERAL") {
            TextField("Name", text: $name)
                .onChange(of: name) {
                    if name.count > 75 {
                        name = String(name.prefix(75))
                    }
                }
            PhotosPicker(
                selection: $imageSelection,
                matching: .images,
                photoLibrary: .shared()
            ) {
                HStack {
                    Text("Image")
                    Spacer()
                    if isImageLoading {
                        ProgressView()
                    } else if let selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    } else {
                        Text("Add")
                            .foregroundColor(.gray)
                    }
                }
            }.onChange(of: imageSelection) { oldItem, newItem in
                guard let item = newItem else { return }
                isImageLoading = true

                Task {
                    if let data = try? await item.loadTransferable(type: Data.self),
                        let uiImage = UIImage(data: data)
                    {
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

            DatePicker(
                "Duration",
                selection: Binding(
                    get: {
                        Calendar.current.date(from: DateComponents(hour: hours, minute: minutes))
                            ?? Date()
                    },
                    set: { newDate in
                        let components = Calendar.current.dateComponents(
                            [.hour, .minute], from: newDate)
                        hours = components.hour ?? 0
                        minutes = components.minute ?? 0
                    }
                ),
                displayedComponents: .hourAndMinute
            )

            HStack {
                Text("Portions")
                Spacer()
                Stepper(
                    value: $servings,
                    in: 1...20,
                    label: {
                        Text("\(servings)")
                            .foregroundColor(.gray)
                    }
                )
            }
        }
    }
}
