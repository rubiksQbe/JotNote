//
//  NoteListView.swift
//  JotNote
//
//  Created by Tina Zheng on 6/4/25.
//

import SwiftUI
import SwiftData

struct NoteListView: View {
    // MARK: Data Shared with Me
    var notebook: Notebook
    
    // MARK: Data Out Function
    let deleteNotebook: () -> Void

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    // MARK: Data Owned by Me
    @State private var showingAddNote = false
    @State private var showingEditNotebook = false
    @State private var noteToDelete: Note? = nil
    @State private var showDeleteAlert = false

    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 14) {
                    ForEach(notebook.notes, id: \.id) { note in
                        noteLink(for: note)
                            .padding(.horizontal, 7)
                    }
                }
                .padding(.horizontal, 13)
                .padding(.bottom, 7)
            }
            .navigationTitle(notebook.title)
            .toolbar {
                toolbarButtons()
            }
            .sheet(isPresented: $showingAddNote) {
                AddNoteView(notebook: notebook)
                    .environment(\.modelContext, context)
            }
            .sheet(isPresented: $showingEditNotebook) {
                EditNotebookView(notebook: notebook) {
                    deleteNotebook()
                    dismiss()
                }
            }
            .alert("Delete Note?", isPresented: $showDeleteAlert) {
                Button("Delete", role: .destructive) {
                    if let note = noteToDelete {
                        //withAnimation {
                        noteToDelete = nil
                        context.delete(note)
                        notebook.notes.removeAll { $0.id == note.id }
                        do {
                            try context.save()
                        } catch {
                            print("Save failed: \(error)")
                        }
                        //}
                    }
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("This action cannot be undone.")
            }
        }
    }

    private func noteLink(for note: Note) -> some View {
        NavigationLink {
            NoteView(note: note) {
                noteToDelete = nil
                context.delete(note)
                notebook.notes.removeAll { $0.id == note.id }
                do {
                    try context.save()
                } catch {
                    print("Save failed: \(error)")
                }
            }
        } label: {
            NotePreviewView(note: note)
        }
        .contextMenu {
            Button(role: .destructive) {
                noteToDelete = note
                showDeleteAlert = true
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }

    private func toolbarButtons() -> some View {
        HStack {
            Button {
                showingEditNotebook = true
            } label: {
                Image(systemName: "pencil")
            }

            Button {
                showingAddNote = true
            } label: {
                Image(systemName: "plus")
            }
        }
    }
}

#Preview {
//    NoteListView()
}
