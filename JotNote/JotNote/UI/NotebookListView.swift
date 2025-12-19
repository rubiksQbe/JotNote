//
//  NotebookListView.swift
//  JotNote
//
//  Created by Tina Zheng on 6/11/25.
//

import SwiftUI
import SwiftData

struct NotebookListView: View {
    @Query(sort: \Notebook.title) private var notebooks: [Notebook]
    @Environment(\.modelContext) private var context
    
    // MARK: Data Owned by Me
    @State private var showingAddNotebook = false
    @State private var notebookToDelete: Notebook? = nil
    @State private var showDeleteAlert = false
    @State private var notebookToEdit: Notebook? = nil
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(notebooks, id: \.id) { notebook in
                        notebookLink(for: notebook)
                    }
                }
                .padding(.horizontal, 20)
                .navigationTitle("Notebooks")
                .toolbar {
                    Button {
                        showingAddNotebook = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddNotebook) {
                AddNotebookView()
                    .environment(\.modelContext, context)
            }
            .sheet(item: $notebookToEdit) { notebook in
                EditNotebookView(notebook: notebook) {
                    context.delete(notebook)
                }
            }
            .alert("Delete Notebook?", isPresented: $showDeleteAlert) {
                Button("Delete", role: .destructive) {
                    if let notebook = notebookToDelete {
                        withAnimation {
                            context.delete(notebook)
                        }
                    }
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("This action deletes the notebook and permanently deletes all notes inside.")
            }
        }
        .task {
            if notebooks.isEmpty {
                Notebook.insertSampleData(into: context)
            }
        }
    }

    @ViewBuilder
    private func notebookLink(for notebook: Notebook) -> some View {
        NavigationLink {
            NoteListView(notebook: notebook) {
                context.delete(notebook)
            }
        } label: {
            NotebookView(theme: .constant(notebook.theme), title: .constant(notebook.title), cover: .constant(notebook.cover))
        }
        .buttonStyle(.plain)
        .contextMenu {
            Button {
                notebookToEdit = notebook
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            Button(role: .destructive) {
                notebookToDelete = notebook
                showDeleteAlert = true
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}


#Preview {
    NotebookListView()
}
