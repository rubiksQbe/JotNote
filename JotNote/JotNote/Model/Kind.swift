//
//  Kind.swift
//  JotNote
//
//  Created by Tina Zheng on 6/3/25.
//

import Foundation
import SwiftData

@Model
class FreeWriteContent {
    var text: String
    var font: String
    
    init(text: String = "", font: String = "Helvetica") {
        self.text = text
        self.font = font
    }
}

@Model
class ToDoContent {
    @Relationship(deleteRule: .cascade) var items: [Item]
    
    init(items: [Item] = []) {
        self.items = items
    }
    
    func add(_ item: Item) {
        items.append(item)
    }
    
    func delete(at index: Int) {
        items.remove(at: index)
        if items.filter({ !$0.done }).isEmpty {
            items.append(Item())
        }
    }
}

enum Kind: String, Codable {
    case freeWrite
    case toDo
}
