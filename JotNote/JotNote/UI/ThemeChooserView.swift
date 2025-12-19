//
//  ThemeChooserView.swift
//  JotNote
//
//  Created by Tina Zheng on 6/10/25.
//

import SwiftUI
import ThemeKit

struct ThemeChooserView: View {
    // MARK: Data Shared with Me
    @Binding var selection: Theme
    
    let themes: [Theme] = Theme.allCases
    let columns = Array(repeating: GridItem(.flexible()), count: 4)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {  // https://developer.apple.com/documentation/swiftui/lazyvgrid
            ForEach(themes, id: \.self) { theme in
                Button {
                    withAnimation {
                        selection = theme
                    }
                } label: {
                    buttonLabel(theme: theme)
                }
                .buttonStyle(.plain)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: selection)
    }
    
    @ViewBuilder
    private func buttonLabel(theme: Theme) -> some View {
        ZStack {
            Circle()
                .fill(theme.mainColor)
                .frame(width: 50, height: 50)
                .overlay(
                    Circle()
                        .stroke(selection == theme ? theme.accentColor : .clear, lineWidth: 3)
                )
                .animation(.easeInOut(duration: 0.2), value: selection)
            if selection == theme {
                Image(systemName: "checkmark")
                    .foregroundStyle(theme.accentColor)
                    .transition(.scale.combined(with: .opacity))
            }
        }
    }
}

#Preview {
    @Previewable @State var note: Note = Note.toDoSampleData[1]
    ThemeChooserView(selection: $note.theme)
}
