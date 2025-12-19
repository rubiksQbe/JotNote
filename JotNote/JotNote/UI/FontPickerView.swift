//
//  FontPickerView.swift
//  JotNote
//
//  Created by Tina Zheng on 6/10/25.
//

import SwiftUI

struct FontPickerView: View {
    // MARK: Data Shared with Me
    @Bindable var content: FreeWriteContent

    // MARK: Data Owned by Me
    @State private var previewText: String = "Preview Text"
    
    let fonts = [
        "American Typewriter",
        "Arial",
        "Avenir",
        "Avenir Next",
        "Baskerville",
        "Chalkboard SE",
        "Copperplate",
        "Courier",
        "Courier New",
        "DIN Alternate",
        "DIN Condensed",
        "Didot",
        "Futura",
        "Georgia",
        "Gill Sans",
        "Helvetica",
        "Helvetica Neue",
        "Hoefler Text",
        "Marker Felt",
        "Menlo",
        "Noteworthy",
        "Optima",
        "Palatino",
        "Snell Roundhand",
        "Times New Roman",
        "Trebuchet MS",
        "Verdana",
        "Zapfino"
    ]

    var body: some View {
        Picker("Font", selection: $content.font) {
            ForEach(fonts, id: \.self) { fontName in
                Text(fontName)
                    .tag(fontName)
            }
        }
        .pickerStyle(.menu)
        TextField("Preview Text", text: $previewText)
            .font(.custom(content.font, size: 16))
    }
}

#Preview {
    @Previewable var content = FreeWriteContent(text: "Test", font: "Arial")
    FontPickerView(content: content)
}
