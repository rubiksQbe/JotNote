//
//  NotebookEditingView.swift
//  JotNote
//
//  Created by Tina Zheng on 6/11/25.
//

import SwiftUI
import PhotosUI

struct NotebookEditingView: View {
    // MARK: Data Shared with Me
    var notebook: Notebook
    
    // MARK: Data Out Function
    let delete: () -> Void

    // MARK: Data Owned by Me
    @Environment(\.dismiss) private var dismiss
    @State private var showAlert = false
    @State private var alertType: AlertType?
    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    
    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("New Notebook", text: Binding(
                    get: { notebook.title },
                    set: { notebook.title = $0 }
                ))
            }
            Section(header: Text("Customize Cover")) {
                SpineColorPickerView(selection: Binding(
                    get: { notebook.theme },
                    set: { notebook.theme = $0 }
                ))
                coverChooser()
            }
            Button("Empty Contents") {
                alertType = .clearOut
                showAlert = true
            }
            .foregroundStyle(.red)
            .disabled(notebook.notes.isEmpty)
            Button("Delete Notebook") {
                alertType = .deleteNotebook
                showAlert = true
            }
            .fontWeight(.bold)
            .foregroundStyle(.red)
        }
        .alert("Are you sure?", isPresented: $showAlert, presenting: alertType) { type in
            Button("Cancel", role: .cancel) {}
            
            Button("Yes", role: .destructive) {
                switch type {
                case .clearOut:
                    notebook.notes.removeAll()
                case .deleteNotebook:
                    delete()
                    dismiss()
                }
            }
        } message: { type in
            switch type {
            case .clearOut:
                Text("This action permanently deletes all notes inside the notebook.")
            case .deleteNotebook:
                Text("This action deletes the notebook and permanently deletes all notes inside.")
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
                    dismiss()
                }
            }
        }
    }
    
    @ViewBuilder
    private func coverChooser() -> some View {
        VStack {
            if let data = notebook.cover, let uiImage = UIImage(data: data) {
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
            PhotosPicker("Select Cover Photo", selection: $selectedPhotoItem, matching: .images)
                .onChange(of: selectedPhotoItem) { _, newItem in
                    loadImage(from: newItem)
                }
                .padding(3)
        }
    }
    
    private func loadImage(from item: PhotosPickerItem?) {
        guard let item = item else { return }
        _ = item.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let data = data {
                        notebook.cover = data
                    }
                case .failure(let error):
                    print("Failed to load image: \(error.localizedDescription)")
                }
            }
        }
    }
    
    enum AlertType {
        case clearOut
        case deleteNotebook
    }
}


#Preview {
//    @Previewable @State var notebook: Notebook = Notebook.sampleData[0]
//    NotebookEditingView(notebook: $notebook, delete: {})
}
