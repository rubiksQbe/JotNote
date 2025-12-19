//
//  FreeWritePreviewView.swift
//  JotNote
//
//  Created by Tina Zheng on 6/4/25.
//

import SwiftUI
import ThemeKit

struct FreeWritePreviewView: View {
    // MARK: Data In
    let content: FreeWriteContent
    let theme: Theme
    let title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text(title)
                    .font(.system(size: 18))
                    .font(.headline)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(theme.accentColor)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                Spacer()
            }
            Text(content.text)
                .font(.system(size: 15))
                .multilineTextAlignment(.leading)
                .truncationMode(.tail)  // https://developer.apple.com/documentation/swiftui/view/truncationmode(_:)
                .padding(.leading, 5)
                .padding(.trailing, 5)
                .padding(.top, 5)
                .foregroundStyle(theme.accentColor)
            Spacer()
        }
        .padding(.top, 5)
        .padding(5)
    }
}

#Preview {
    @Previewable var content = FreeWriteContent(text: "Test")
    FreeWritePreviewView(content: content, theme: .periwinkle, title: "Title")
}
