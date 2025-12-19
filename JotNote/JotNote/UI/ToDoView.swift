//
//  ToDoView.swift
//  JotNote
//
//  Created by Tina Zheng on 6/3/25.
//

import SwiftUI
import ThemeKit

struct ToDoView: View {
    // MARK: Data Shared with Me
    @Bindable var content: ToDoContent

    // MARK: Data In
    let theme: Theme

    // MARK: Data Owned by Me
    @FocusState private var focusedItemID: UUID?
    @Environment(\.dismiss) private var dismiss
    @Namespace private var itemTransition

    var body: some View {
        List {
            ForEach($content.items) { $item in
                if !item.done {
                    activeItemRow(item: $item)
                }
            }
            // GPT: how to go get only completed items
            let completedItems = $content.items.filter { $0.wrappedValue.done }
            if !completedItems.isEmpty {
                complete()
                ForEach(completedItems) { $item in
                    completedItemRow(item: $item)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                withAnimation {
                    doneOrClose()
                }
            }
        }
        .environment(\.defaultMinListRowHeight, 30)  // GPT: how to make space between list items less
        .scrollContentBackground(.hidden)
        .listStyle(.plain)
        .background(theme.mainColor)
        .onAppear {
            withAnimation {
                content.items.append(Item())
            }
        }
    }

    @ViewBuilder
    private func activeItemRow(item: Binding<Item>) -> some View {
        ItemView(item: item, theme: theme) {
            withAnimation {
                if item.text.wrappedValue != "" {
                    let newItem = Item()
                    if let idx = content.items.firstIndex(where: { $0.id == item.id }) {
                        content.items.insert(newItem, at: idx + 1)
                        focusedItemID = newItem.id
                    }
                }
            }
        }
        .matchedGeometryEffect(id: item.id, in: itemTransition)
        .transition(.move(edge: .top))
        .focused($focusedItemID, equals: item.wrappedValue.id)
        .swipeActions(edge: .trailing) {  // https://developer.apple.com/documentation/swiftui/view/swipeactions(edge:allowsfullswipe:content:)
            delete(id: item.wrappedValue.id)
        }
        .modifier(ItemStyle(theme: theme))
        .onChange(of: item.wrappedValue.text) { _, newValue in
            if !newValue.isEmpty,
               content.items.last?.id == item.wrappedValue.id {
                withAnimation {
                    content.items.append(Item())
                }
            }
        }
    }

    @ViewBuilder
    private func completedItemRow(item: Binding<Item>) -> some View {
        ItemView(item: item, theme: theme)
            .matchedGeometryEffect(id: item.id, in: itemTransition)
            .transition(.move(edge: .top))
            .focused($focusedItemID, equals: item.wrappedValue.id)
            .swipeActions(edge: .trailing) {
                delete(id: item.wrappedValue.id)
            }
            .modifier(ItemStyle(theme: theme))
            .opacity(0.5)
    }

    @ViewBuilder
    private func delete(id: UUID) -> some View {
        Button(role: .destructive) {
            if let idx = content.items.firstIndex(where: { $0.id == id }) {
                content.delete(at: idx)
            }
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }

    @ViewBuilder
    private func complete() -> some View {
        HStack {
            Text("Completed")
                .font(.caption)
                .foregroundStyle(theme.accentColor)
                .opacity(0.5)
                .padding(.leading, 2)
                .padding(.top, 20)
            Spacer()
        }
        .listRowBackground(theme.mainColor)
    }

    // remove all empty Items except last one
    private func removeExtra() {
        let emptyIndices = content.items.indices.filter { content.items[$0].text.isEmpty }
        for index in emptyIndices.dropLast().reversed() {
            content.items.remove(at: index)
        }
    }

    @ViewBuilder
    private func doneOrClose() -> some View {
        Group {
            if focusedItemID != nil {
                Button("Done") {
                    focusedItemID = nil
                    removeExtra()
                }
            } else {
                Button("Close") {
                    focusedItemID = nil
                    removeExtra()
                    if content.items.last?.text == "" {
                        content.items.removeLast()
                    }
                    dismiss()
                }
            }
        }
        .font(.system(.body, weight: .light))
        .foregroundStyle(theme.accentColor)
    }
}

struct ItemStyle: ViewModifier {
    let theme: Theme
    
    func body(content: Content) -> some View {
        content
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))  // https://developer.apple.com/documentation/swiftui/view/listrowinsets(_:)
            .listRowBackground(theme.mainColor)
            .listRowSeparator(.hidden)
    }
}

#Preview {
    @Previewable var content = ToDoContent(items: [Item(text: "Test 1", done: false), Item(text: "Test 2", done: false), Item(text: "Test 3", done: false)])
    ToDoView(content: content, theme: .poppy)
}
