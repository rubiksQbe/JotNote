//
//  ContentView.swift
//  JotNote
//
//  Created by Tina Zheng on 6/3/25.
//

import SwiftUI

struct NoteView: View {
    // MARK: Data Shared with Me
    var note: Note
    
    // MARK: Data Out Function
    let delete: () -> Void
    
    // MARK: Data Owned by Me
    @State private var showingEditNote = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            switch note.kind {
            case .freeWrite:
                if let content = note.freeWriteContent {
                    FreeWriteView(content: content, theme: note.theme)
                }
            case .toDo:
                if let content = note.toDoContent {
                    ToDoView(content: content, theme: note.theme)
                }
            }
        }
        .padding(.top, 10)
        .background(note.theme.mainColor)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Edit") {
                    showingEditNote = true
                }
                .font(.system(.body, weight: .light))
                .foregroundStyle(note.theme.accentColor)
            }
            ToolbarItem(placement: .principal) {
                TextField("Title", text: Binding(
                    get: { note.title },
                    set: { note.title = $0 }
                ))
                    .font(.headline)
                    .foregroundStyle(note.theme.accentColor)
                    .multilineTextAlignment(.center)  // https://developer.apple.com/documentation/swiftui/view/multilinetextalignment(_:)
                    .autocorrectionDisabled(true)
                    .frame(maxWidth: 200)
            }
        }
        .sheet(isPresented: $showingEditNote) {
            EditNoteView(note: note) {
                delete()
                dismiss()
            }
        }
        .navigationBarTitleDisplayMode(.inline)  // make title small and fit in nav bar
        .toolbarBackground(note.theme.mainColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)  // GPT: navigation bar turns white when scrolling
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    // @Previewable @State var note: Note = Note.freeWriteSampleData[1]
    @Previewable @State var note: Note = Note.toDoSampleData[1]
    NoteView(note: note, delete: {})
}
