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
            }
        }
        .background(
            VisualEffectBlurView(blurStyle: .systemUltraThinMaterialDark)
                .edgesIgnoringSafeArea(.all)
        )
    }
}
