//
//  EditNotebookView.swift
//  JotNote
//
//  Created by Tina Zheng on 6/11/25.
//

import SwiftUI
import SwiftData

struct EditNotebookView: View {
    // MARK: Data Shared with Me
    var notebook: Notebook
    
    // MARK: Data Out Function
    let delete: () -> Void
    
    // MARK: Data Owned by Me
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            NotebookEditingView(notebook: notebook) {
                delete()
                dismiss()
            }
        }
    }
}

#Preview {
    //EditNotebookView()
}
