//
//  ItemView.swift
//  JotNote
//
//  Created by Tina Zheng on 6/3/25.
//

import SwiftUI
import ThemeKit

struct ItemView: View {
    // MARK: Data Shared with Me
    @Binding var item: Item
    
    // MARK: Data In
    let theme: Theme
    var onCommit: (() -> Void)? = nil
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: item.done ? "checkmark.square" : "square")
                .foregroundStyle(theme.accentColor)
                .padding(.top, 1)
                .onTapGesture {
                    if item.text != "" {
                        withAnimation(.bouncy) {
                            item.done = !item.done
                        }
                    }
                }
            ZStack(alignment: .leading) {
                if item.text.isEmpty {  // to adjust placeholder text color
                    Text("New Item")
                        .foregroundStyle(theme.accentColor)
                        .opacity(0.5)
                }
                TextField("", text: $item.text)
                    .strikethrough(item.done)  // https://developer.apple.com/documentation/swiftui/view/strikethrough(_:pattern:color:)
                    .lineLimit(1)
                    .foregroundStyle(theme.accentColor)
                    .autocorrectionDisabled(true)
                    .onSubmit {
                        onCommit?()
                    }
            }
        }
        .padding(.leading)
    }
}

#Preview {
    @Previewable @State var item = Item(text: "Test", done: false)
    ItemView(item: $item, theme: .buttercup)
}
