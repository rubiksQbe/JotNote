//
//  FreeWriteView.swift
//  JotNote
//
//  Created by Tina Zheng on 6/3/25.
//

import SwiftUI
import ThemeKit

struct FreeWriteView: View {
    // MARK: Data Shared with Me
    @Bindable var content: FreeWriteContent
    
    // MARK: Data In
    let theme: Theme
    
    // MARK: Data Owned by Me
    // https://developer.apple.com/documentation/swiftui/focusstate
    @FocusState private var isTextFieldFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            TextEditor(text: $content.text)  // https://developer.apple.com/documentation/swiftui/texteditor
                .foregroundStyle(theme.accentColor)
                .font(.custom(content.font, size: 21))
                .lineSpacing(5)
                .padding()
                .scrollContentBackground(.hidden)  // https://stackoverflow.com/questions/62848276/change-background-color-of-texteditor-in-swiftui
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowBackground(theme.mainColor)
                .focused($isTextFieldFocused)
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Group {
                    if isTextFieldFocused {
                        Button("Done") {
                            isTextFieldFocused = false
                        }
                    } else {
                        Button("Close") {
                            dismiss()
                        }
                    }
                }
                .font(.system(.body, weight: .light))
                .foregroundStyle(theme.accentColor)
            }
        }
        .scrollContentBackground(.hidden)
        .listStyle(.plain)
        .background(theme.mainColor)
    }
}

#Preview {
    @Previewable var content = FreeWriteContent(text: "Test")
    FreeWriteView(content: content, theme: .periwinkle)
}
