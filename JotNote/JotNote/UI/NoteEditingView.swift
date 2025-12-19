//
//  NoteEditingView.swift
//  JotNote
//
//  Created by Tina Zheng on 6/10/25.
//

import SwiftUI
import ThemeKit

struct NoteEditingView: View {
    // MARK: Data Shared with Me
    var note: Note
    
    // MARK: Data Out Function
    let delete: () -> Void

    // MARK: Data Owned by Me
    @Environment(\.dismiss) private var dismiss
    @State private var showAlert = false
    @State private var alertType: AlertType?
    
    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("New Note", text: Binding(
                    get: { note.title },
                    set: { note.title = $0 }
                ))
            }
            Section(header: Text("Theme")) {
                switch note.kind {
                case .freeWrite:
                    if let content = note.freeWriteContent {
                        FontPickerView(content: content)
                    }
                    ThemeChooserView(selection: Binding(
                        get: { note.theme },
                        set: { note.theme = $0 }
                    ))
                case .toDo:
                    ThemeChooserView(selection: Binding(
                        get: { note.theme },
                        set: { note.theme = $0 }
                    ))
                }
            }
            Section(header: Text("Erase Content")) {
                switch note.kind {
                case .freeWrite:
                    if let content = note.freeWriteContent {
                        Button("Clear all text") {
                            content.text = ""
                        }
                        .foregroundStyle(.red)
                        .disabled(content.text == "")  // https://developer.apple.com/documentation/swiftui/view/disabled(_:)
                    }
                case .toDo:
                    if let content = note.toDoContent {
                        Button("Delete all checked Items") {
                            alertType = .deleteCheckedItems
                            showAlert = true
                        }
                        .foregroundStyle(.red)
                        .disabled(!content.items.contains(where: \.done))  // https://developer.apple.com/documentation/swiftui/view/disabled(_:)
                        Button("Uncheck all items") {
                            alertType = .uncheckAllItems
                            showAlert = true
                        }
                        .disabled(!content.items.contains(where: \.done))
                    }
                }
            }
            Button("Delete Note") {
                alertType = .deleteNote
                showAlert = true
            }
            .fontWeight(.bold)
            .foregroundStyle(.red)
        }
        .alert("Are you sure?", isPresented: $showAlert, presenting: alertType) { type in
            Button("Cancel", role: .cancel) {}

            Button("Yes", role: .destructive) {
                // GPT: how to have "are you sure" pop up for both deleting checked items and unchecking all items
                switch type {
                case .deleteCheckedItems:
                    if case .toDo = note.kind {
                        if let content = note.toDoContent {
                            content.items.removeAll(where: \.done)
                        }
                    }

                case .uncheckAllItems:
                    if case .toDo = note.kind {
                        if let content = note.toDoContent {
                            for index in content.items.indices {
                                content.items[index].done = false
                            }
                        }
                    }
                
                case .deleteNote:
                    delete()
                    dismiss()
                }
            }
        } message: { type in
            switch type {
            case .deleteCheckedItems:
                Text("This will permanently delete all checked items.")
            case .uncheckAllItems:
                Text("This will uncheck all your completed items.")
            case .deleteNote:
                Text("This will permanently delete this note.")
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
    
    enum AlertType {
        case deleteCheckedItems
        case uncheckAllItems
        case deleteNote
    }
}

#Preview {
    @Previewable @State var note: Note = Note.toDoSampleData[1]
    //@Previewable @State var note: Note = Note.freeWriteSampleData[1]
    NoteEditingView(note: note, delete: {})
}
