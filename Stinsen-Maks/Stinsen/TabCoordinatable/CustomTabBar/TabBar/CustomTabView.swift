//
//  CustomTabView.swift
//  CustomTabView
//
//  Created by Maksim on 01/03/2022.
//

import SwiftUI

struct CustomTabView<SelectionValue, Content> : View where SelectionValue: Hashable, Content: View {
    
    @State private var tabs = [AnyTabView]()
    private let content: Content
    private var selectionObservable: TabBarSelection<SelectionValue>
    @StateObject private var tabBarStateManager = TabBarStateManager()
    
    init(selection: Binding<SelectionValue>, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.selectionObservable = TabBarSelection(selection: selection)
    }

    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottom) {
                content
                
                TabBar<SelectionValue>(tabViews: tabs)
            }
        }
        .environmentObject(tabBarStateManager)
        .environmentObject(selectionObservable)
        .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
            self.tabs = value
        }
    }
}

