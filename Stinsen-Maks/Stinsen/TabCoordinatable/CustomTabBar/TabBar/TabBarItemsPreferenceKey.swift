//
//  TabBarItemViewModifier.swift
//  CustomTabView
//
//  Created by Maksim on 01/03/2022.
//

import SwiftUI

struct TabBarItemsPreferenceKey: PreferenceKey {
    
    static var defaultValue: [AnyTabView] = []
    
    static func reduce(value: inout [AnyTabView], nextValue: () -> [AnyTabView]) {
        value += nextValue()
    }
    
}

struct TabBarItemViewModifier<Selection, TabViewType>: ViewModifier where Selection: Hashable, TabViewType: View{
    
    let tab: Selection
    let viewBuilder: (Bool) -> TabViewType
    @EnvironmentObject private var selectionObject: TabBarSelection<Selection>
    
    func body(content: TabBarItemViewModifier.Content) -> some View {
//        Group {
//            if tab == selectionObject.selection {
//                content
//            } else {
//                Color.clear
//            }
//        }
        content
            .opacity(selectionObject.selection == tab ? 1 : 0)
            .preference(
                key: TabBarItemsPreferenceKey.self,
                value: [AnyTabView(
                    viewBuilder: { isSelected in
                        AnyView(viewBuilder(isSelected))
                    },
                    tab: tab
                )]
            )
    }
}


extension View {
    
    func tabBarItem<Selection: Hashable, Content: View>(tab: Selection, content: @escaping (Bool) -> Content) -> some View {
        modifier(TabBarItemViewModifier(tab: tab, viewBuilder: content))
    }
    
//    func tabBarItem<Selection: Hashable, Content: View>(tab: Selection, content: @escaping () -> Content) -> some View {
//        modifier(TabBarItemViewModifier(tab: tab, tabView: content()))
//    }
    
}
