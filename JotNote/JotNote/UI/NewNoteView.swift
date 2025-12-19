//
//  NewNoteView.swift
//  JotNote
//
//  Created by Tina Zheng on 6/10/25.
//

import SwiftUI
import ThemeKit

struct NewNoteView: View {
    // MARK: Data Shared with Me
    @Binding var note: Note
    
    // MARK: Data Out Function
    let saveEdits: () -> Void

    // MARK: Data Owned by Me
    @Environment(\.dismiss) private var dismiss
    @State private var noteType: String = "Free Write"
    
    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("New Note", text: $note.title)
            }
            Section(header: Text("Theme")) {
                ThemeChooserView(selection: $note.theme)
            }
            Section(header: Text("Note Type")) {
                Picker(selection: $noteType) {
                    Text("Free Write").tag("Free Write")
                    Text("To Do").tag("To Do")
                } label: {
                    // don't want label
                }
                .pickerStyle(.inline)
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
                    if noteType == "Free Write" {
                        note.kind = .freeWrite
                        note.freeWriteContent = FreeWriteContent()
                    } else {
                        note.kind = .toDo
                        note.toDoContent = ToDoContent()
                    }
                    saveEdits()
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var note: Note = Note()
    NewNoteView(note: $note, saveEdits: {})
}
