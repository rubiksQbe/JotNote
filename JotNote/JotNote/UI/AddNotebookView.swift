//
//  AddNotebookView.swift
//  JotNote
//
//  Created by Tina Zheng on 6/11/25.
//

import SwiftUI
import SwiftData

struct AddNotebookView: View {
    @Environment(\.modelContext) private var modelContext
    
    // MARK: Data Owned by Me
    @State private var newNotebook = Notebook()
    
    var body: some View {
        NavigationStack {
            NewNotebookView(notebook: $newNotebook) {
                modelContext.insert(newNotebook)
            }
        }
    }
}

#Preview {
    //AddNotebookView()
}
