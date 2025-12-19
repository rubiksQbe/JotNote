//
//  AddNoteView.swift
//  JotNote
//
//  Created by Tina Zheng on 6/10/25.
//

import SwiftUI
import SwiftData

struct AddNoteView: View {
    @Environment(\.modelContext) private var context
    
    var notebook: Notebook
    
    // MARK: Data Owned by Me
    @State private var newNote = Note()
    
    var body: some View {
        NavigationStack {
            NewNoteView(note: $newNote) {
                notebook.notes.append(newNote)
                context.insert(newNote)
            }
        }
    }
}

#Preview {
    //AddNoteView()
}
