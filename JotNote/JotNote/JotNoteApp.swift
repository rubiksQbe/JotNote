//
//  JotNoteApp.swift
//  JotNote
//
//  Created by Tina Zheng on 6/3/25.
//

import SwiftUI
import SwiftData

@main
struct JotNoteApp: App {
    var body: some Scene {
        WindowGroup {
            NotebookListView()
        }
        .modelContainer(for: [
            Notebook.self,
            Note.self,
            FreeWriteContent.self,
            ToDoContent.self,
            Item.self
        ])
    }
}
