//
//  TabBar.swift
//  CustomTabView
//
//  Created by Maksim on 01/03/2022.
//

import SwiftUI

struct TabBar<Selection>: View where Selection: Hashable {
    
    let barHeight: CGFloat = 55
    let tabViews: [AnyTabView]
    @EnvironmentObject private var selectionObject: TabBarSelection<Selection>
    @EnvironmentObject private var tabBarStateManager: TabBarStateManager
    
    var body: some View {
        HStack {
            ForEach(tabViews) { anyTab in
                anyTab.viewBuilder(selectionObject.selection == anyTab.tab as! Selection)
                    .frame(maxHeight: barHeight)
                    .background(Color.black.opacity(0.001)) // workaround to have the background as a touch area
                    .simultaneousGesture(
                        TapGesture()
                            .onEnded { _ in
                                guard let tab = anyTab.tab as? Selection else { return }
//                                withAnimation() {
                                    selectionObject.selection = tab
//                                }
                            }
                    )
                    .offset(getOffset(tab: anyTab.tab as! Int))
                    .opacity(getOpacity(tab: anyTab.tab as! Int))
            }
        }
        .background(
            VisualEffectBlurView(blurStyle: .systemUltraThinMaterialDark)
                .edgesIgnoringSafeArea(.all)
                .offset(getOffset(tab: 0))
                .opacity(getOpacity(tab: 0))
        )
        .animation(.easeOut(duration: 0.3), value: tabBarStateManager.state)
    }
    
    func getOffset(tab: Int) -> CGSize {
        switch tabBarStateManager.state {
        case .fullyShown:
            return CGSize(width: 0 , height: 0)
        case .hidden:
            return CGSize(width: 0, height: 150)
        case .onlyTab(let tabNumber):
            if tab == tabNumber { return CGSize(width: 0 , height: 0) }
            return CGSize(width: 0, height: 150)
        }
    }
    
    func getOpacity(tab: Int) -> Double {
        switch tabBarStateManager.state {
        case .fullyShown:
            return 1
        case .hidden:
            return 0
        case .onlyTab(let tabNumber):
            if tab == tabNumber { return 1 }
            return 0
        }
    }
}
