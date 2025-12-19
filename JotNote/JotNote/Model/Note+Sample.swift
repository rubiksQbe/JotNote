//
//  Note+Sample.swift
//  JotNote
//
//  Created by Tina Zheng on 6/3/25.
//

import Foundation
import ThemeKit
import SwiftData

extension Note {
    static let toDoSampleData: [Note] = [
        Note(title: "Grocery List",
             theme: .poppy,
             kind: .toDo,
             freeWriteContent: nil,
             toDoContent: ToDoContent(items: [Item(text: "Bananas", done: false),
                                 Item(text: "Apples", done: false),
                                 Item(text: "Bread", done: true),
                                 Item(text: "Milk", done: true),
                                 Item(text: "Eggs", done: true),
                                 Item(text: "Cheese", done: true),
                                 Item(text: "Bacon", done: true),
                                 Item(text: "Onion", done: false),
                                 Item(text: "Potatoes", done: false),
                                 Item(text: "Tomatoes", done: false)])),
        Note(title: "Movies to Watch",
             theme: .periwinkle,
             kind: .toDo,
             freeWriteContent: nil,
             toDoContent: ToDoContent(items: [Item(text: "Everything Everywhere All At Once", done: false),
                                 Item(text: "The Half of It", done: false),
                                 Item(text: "Turning Red", done: false),
                                 Item(text: "About Time", done: true)])),
        Note(title: "Book Tracker",
             theme: .magenta,
             kind: .toDo,
             freeWriteContent: nil,
             toDoContent: ToDoContent(items: [Item(text: "The Overstory by Richard Powers", done: false),
                                 Item(text: "The Martian by Andy Weir", done: false),
                                 Item(text: "How to Be Perfect by Michael Schur", done: false),
                                 Item(text: "Tribe by Sebastian Junger", done: false),
                                 Item(text: "Klara and the Sun by Kazuo Ishiguro", done: false),
                                 Item(text: "Welcome to the Hyunam-Dong Bookshop by Hwang Bo-Reum", done: false),
                                 Item(text: "Giovanni's Room by James Baldwin", done: true),
                                 Item(text: "The Joy Luck Club by Amy Tan", done: true),
                                 Item(text: "The Myth of Sisyphus by Albert Camus", done: true)]))
    ]
    
    static let freeWriteSampleData: [Note] = [
        Note(title: "Spring Quarter Reflections",
             theme: .buttercup,
             kind: .freeWrite,
             freeWriteContent: FreeWriteContent(text: "I had a great time learning SwiftUI!"),
             toDoContent: nil),
        Note(title: "Song Lyrics",
             theme: .bubblegum,
             kind: .freeWrite,
             freeWriteContent: FreeWriteContent(text: """
                      We're no strangers to love
                      You know the rules and so do I
                      A full commitment's what I'm thinkin' of
                      You wouldn't get this from any other guy
                      
                      I just wanna tell you how I'm feeling
                      Gotta make you understand
                      
                      Never gonna give you up, never gonna let you down
                      Never gonna run around and desert you
                      Never gonna make you cry, never gonna say goodbye
                      Never gonna tell a lie and hurt you
                      
                      We've known each other for so long
                      Your heart's been aching, but you're too shy to say it
                      Inside, we both know what's been going on
                      We know the game and we're gonna play it
                      
                      And if you ask me how I'm feeling
                      Don't tell me you're too blind to see
                      
                      Never gonna give you up, never gonna let you down
                      Never gonna run around and desert you
                      Never gonna make you cry, never gonna say goodbye
                      Never gonna tell a lie and hurt you
                      
                      Never gonna give you up, never gonna let you down
                      Never gonna run around and desert you
                      Never gonna make you cry, never gonna say goodbye
                      Never gonna tell a lie and hurt you
                      
                      We've known each other for so long
                      Your heart's been aching, but you're too shy to say it
                      Inside, we both know what's been going on
                      We know the game and we're gonna play it
                      
                      I just wanna tell you how I'm feeling
                      Gotta make you understand
                      
                      Never gonna give you up, never gonna let you down
                      Never gonna run around and desert you
                      Never gonna make you cry, never gonna say goodbye
                      Never gonna tell a lie and hurt you
                      
                      Never gonna give you up, never gonna let you down
                      Never gonna run around and desert you
                      Never gonna make you cry, never gonna say goodbye
                      Never gonna tell a lie and hurt you
                      
                      Never gonna give you up, never gonna let you down
                      Never gonna run around and desert you
                      Never gonna make you cry, never gonna say goodbye
                      Never gonna tell a lie and hurt you
                      """),
             toDoContent: nil),
        Note(title: "Sending Love~",
             theme: .indigo,
             kind: .freeWrite,
             freeWriteContent: FreeWriteContent(text: """
                            /ᐢ⑅ᐢ\\   ♡   ₊˚  
                          ꒰ ˶• ༝ •˶꒱       ♡‧₊˚    ♡
                          ./づ~ :¨·.·¨:     ₊˚  
                                   `·..·‘    ₊˚   ♡
                          """),
             toDoContent: nil)
    ]
}

extension Notebook {
    // GPT: I want to preload sample data for notebooks
    @MainActor
    static func insertSampleData(into context: ModelContext) {
        let notebooks = [
            Notebook(title: "Blossom", theme: .orange),
            Notebook(title: "Buttercup", theme: .navy),
            Notebook(title: "Bubbles", theme: .yellow)
        ]
        
        let notes = Note.freeWriteSampleData + Note.toDoSampleData
        for note in notes {
            context.insert(note)
        }

        notebooks[0].notes = [notes[0], notes[3]]
        notebooks[1].notes = [notes[1], notes[4]]
        notebooks[2].notes = [notes[2], notes[5]]

        for notebook in notebooks {
            context.insert(notebook)
        }
        
        do {
            try context.save()
        } catch {
            print("⚠️ Failed to save sample data: \(error)")
        }
    }
}
