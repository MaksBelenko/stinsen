//
//  File.swift
//  
//
//  Created by Maksim on 02/05/2022.
//

import Foundation
import SwiftUI

public enum TabStyle {
    case teleprom
    case standard
}

struct CustomTabCoordinatableView<T: TabCoordinatable, U: View>: View {
    private var coordinator: T
    private let router: TabRouter<T>
    @ObservedObject var child: TabChild
    private var customize: (AnyView) -> U
    private var views: [AnyView]
    
    var body: some View {
        customize(
            AnyView(
                CustomTabView(selection: $child.activeTab) {
                    ForEach(Array(views.enumerated()), id: \.offset) { view in
                        view
                            .element
                            .tabBarItem(tab: view.offset) { isSelected in
                                coordinator.child.allItems[view.offset].tabItem(isSelected)
                            }
                    }
                }
            )
        )
        .environmentObject(router)
    }
    
    init(paths: [AnyKeyPath], coordinator: T, customize: @escaping (AnyView) -> U) {
        self.coordinator = coordinator
        
        self.router = TabRouter(coordinator: coordinator.routerStorable)
        RouterStore.shared.store(router: router)
        self.customize = customize
        self.child = coordinator.child
        
        if coordinator.child.allItems == nil {
            coordinator.setupAllTabs()
        }

        self.views = coordinator.child.allItems.map {
            $0.presentable.view()
        }
    }
}
