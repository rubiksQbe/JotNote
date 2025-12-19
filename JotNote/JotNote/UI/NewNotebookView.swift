//
//  NewNotebookView.swift
//  JotNote
//
//  Created by Tina Zheng on 6/11/25.
//

import SwiftUI
import ThemeKit
import PhotosUI

struct NewNotebookView: View {
    // MARK: Data Shared with Me
    @Binding var notebook: Notebook
    let saveEdits: () -> Void

    // MARK: Data Owned by Me
    @Environment(\.dismiss) private var dismiss
    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    @State private var coverImage: Data? = nil
    
    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("New Notebook", text: $notebook.title)
            }
            Section(header: Text("Customize Cover")) {
                ThemeChooserView(selection: $notebook.theme)
                VStack {
                    if let data = coverImage, let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 200)
                            .cornerRadius(8)
                    } else {
                        Rectangle()
                            .fill(Color.secondary.opacity(0.2))
                            .frame(height: 200)
                            .overlay(Text("No Cover Photo").foregroundColor(.secondary))
                            .cornerRadius(8)
                    }
                    // GPT: how to add ability to upload cover photo
                    PhotosPicker("Select Cover Photo", selection: $selectedPhotoItem, matching: .images)
                        .onChange(of: selectedPhotoItem) { _, newItem in
                            loadImage(from: newItem)
                        }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    saveEdits()
                    dismiss()
                }
            }
        }
    }
    
    // GPT: how to add ability to upload cover photo
    private func loadImage(from item: PhotosPickerItem?) {
        guard let item = item else { return }
        _ = item.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let data = data {
                        self.coverImage = data
                        notebook.cover = coverImage
                    }
                case .failure(let error):
                    print("Failed to load image: \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var notebook: Notebook = Notebook()
    NewNotebookView(notebook: $notebook, saveEdits: {})
}
