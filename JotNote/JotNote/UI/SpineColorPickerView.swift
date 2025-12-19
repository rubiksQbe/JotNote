//
//  SpineColorPickerView.swift
//  JotNote
//
//  Created by Tina Zheng on 6/11/25.
//

import SwiftUI
import ThemeKit

struct SpineColorPickerView: View {
    @Binding var selection: Theme
    
    var body: some View {
        // modified from Apple Swift UI Tutorial Scrumdinger App
        Picker("Spine Color", selection: $selection) {
            ForEach(Theme.allCases) { theme in
                Text(theme.name)
                    .padding(4)
                    .frame(maxWidth: .infinity)
                    .background(theme.mainColor)
                    .foregroundColor(theme.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .tag(theme)
            }
        }
        .pickerStyle(.navigationLink)
        .padding(3)
    }
}

#Preview {
    @Previewable @State var theme: Theme = .bubblegum
    SpineColorPickerView(selection: $theme)
}
