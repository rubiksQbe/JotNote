//
//  NotebookView.swift
//  JotNote
//
//  Created by Tina Zheng on 6/11/25.
//

import SwiftUI
import ThemeKit

struct NotebookView: View {
    // MARK: Data Shared with Me
    @Binding var theme: Theme
    @Binding var title: String
    @Binding var cover: Data?
    
    var body: some View {
        VStack {
            ZStack {
                // https://developer.apple.com/documentation/swiftui/unevenroundedrectangle
                UnevenRoundedRectangle(
                    cornerRadii: .init(  // https://developer.apple.com/documentation/swiftui/rectanglecornerradii
                        topLeading: 0,
                        bottomLeading: 0,
                        bottomTrailing: 10,
                        topTrailing: 10,
                                      )
                )
                .fill(theme.mainColor)
                .frame(width: 150, height: 180)
                .contentShape(Rectangle())
                if let data = cover, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 130, height: 180)
                        .clipShape(
                            UnevenRoundedRectangle(
                                cornerRadii: .init(
                                    topLeading: 0,
                                    bottomLeading: 0,
                                    bottomTrailing: 10,
                                    topTrailing: 10,
                                )
                            )
                        )
                        .padding(.leading, 20)
                }
            }
            Text(title)
                .font(.title2)
                .foregroundStyle(.primary)
        }
    }
}

#Preview {
    @Previewable @State var theme: Theme = .bubblegum
    @Previewable @State var title: String = "Test"
    @Previewable @State var cover: Data? = nil
    NotebookView(theme: $theme, title: $title, cover: $cover)
}
