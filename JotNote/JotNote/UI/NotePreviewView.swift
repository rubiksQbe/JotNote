//
//  NotePreviewView.swift
//  JotNote
//
//  Created by Tina Zheng on 6/3/25.
//

import SwiftUI

struct NotePreviewView: View {
    // MARK: Data Shared with Me
    var note: Note
    
    var body: some View {
        switch note.kind {
        case .freeWrite:
            if let content = note.freeWriteContent {
                FreeWritePreviewView(content: content, theme: note.theme, title: note.title)
                    .frame(width: 180, height: 180)
                    .contentShape(Rectangle())
                    .background(note.theme.mainColor)
            }
        case .toDo:
            if let content = note.toDoContent {
                ToDoPreviewView(content: content, theme: note.theme, title: note.title)
                    .frame(width: 180, height: 180)
                    .contentShape(Rectangle())
                    .background(note.theme.mainColor)
            }
        }
    }
}

#Preview {
    @Previewable @State var note: Note = Note.freeWriteSampleData[1]
    //@Previewable @State var note: Note = Note.toDoSampleData[1]
    NotePreviewView(note: note)
}
