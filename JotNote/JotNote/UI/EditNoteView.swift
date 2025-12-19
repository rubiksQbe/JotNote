//
//  EditNoteView.swift
//  JotNote
//
//  Created by Tina Zheng on 6/10/25.
//

import SwiftUI
import SwiftData

struct EditNoteView: View {
    // MARK: Data Shared with Me
    var note: Note
    
    // MARK: Data Out Function
    let delete: () -> Void
    
    // MARK: Data Owned by Me
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            NoteEditingView(note: note) {
                delete()
                dismiss()
            }
        }
    }
}

#Preview {
    @Previewable @State var note: Note = Note()
    EditNoteView(note: note, delete: {})
}
