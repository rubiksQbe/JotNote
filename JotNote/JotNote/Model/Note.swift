//
//  Note.swift
//  JotNote
//
//  Created by Tina Zheng on 6/3/25.
//

import Foundation
import ThemeKit
import SwiftUI
import SwiftData

@Model
class Item {
    @Attribute(.unique) var id = UUID()  // https://developer.apple.com/documentation/swiftdata/attribute(_:originalname:hashmodifier:)
    var text: String = ""
    var done: Bool = false
    
    init(text: String = "", done: Bool = false) {
        self.text = text
        self.done = done
    }
}

@Model
class Note {
    var title: String
    var theme: Theme
    var kind: Kind
    var freeWriteContent: FreeWriteContent?
    var toDoContent: ToDoContent?
    
    init(title: String = "", theme: Theme = .bubblegum, kind: Kind = .freeWrite, freeWriteContent: FreeWriteContent? = nil, toDoContent: ToDoContent? = nil) {
        self.title = title
        self.theme = theme
        self.kind = kind
        self.freeWriteContent = freeWriteContent
        self.toDoContent = toDoContent
    }
}

@Model
class Notebook {
    var title: String
    var theme: Theme
    @Relationship(deleteRule: .cascade) var notes: [Note]
    var cover: Data?
    @Attribute(.unique) var id = UUID()
    
    init(title: String = "New Notebook", theme: Theme = .bubblegum, notes: [Note] = [], cover: Data? = nil) {
        self.title = title
        self.theme = theme
        self.notes = notes
        self.cover = cover
    }
}
