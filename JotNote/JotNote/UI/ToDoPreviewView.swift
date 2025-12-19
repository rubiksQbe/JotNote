//
//  ToDoPreviewView.swift
//  JotNote
//
//  Created by Tina Zheng on 6/4/25.
//

import SwiftUI
import ThemeKit

struct ToDoPreviewView: View {
    // MARK: Data In
    let content: ToDoContent
    let theme: Theme
    let title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text(title)
                    .font(.system(size: 18))
                    .font(.headline)
                    .bold()
                    .foregroundStyle(theme.accentColor)
                    .padding(.leading, 5)
                    .padding(.bottom, 5)
                Spacer()
            }
            // https://developer.apple.com/documentation/swift/string/prefix(_:)
            // GPT: how to show completed items first
            ForEach(content.items.sorted { !$0.done && $1.done }.prefix(5)) { item in
                HStack {
                    Image(systemName: item.done ? "checkmark.square" : "square")
                        .font(.system(size: 15))
                        .foregroundStyle(theme.accentColor)
                    Text(item.text)
                        .font(.system(size: 15))
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .foregroundStyle(theme.accentColor)
                }
                .padding(.leading, 5)
                .padding(.trailing, 5)
            }
            Spacer()
        }
        .padding(.top, 5)
        .padding(5)
    }
}

#Preview {
    @Previewable let content = ToDoContent(items: [Item(text: "This is a really long line of text", done: false), Item(text: "Test 2", done: false), Item(text: "Test 3", done: true)])
    ToDoPreviewView(content: content, theme: .sky, title: "Title")

}
