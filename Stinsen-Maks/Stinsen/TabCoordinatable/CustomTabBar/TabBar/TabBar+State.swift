//
//  File.swift
//  
//
//  Created by Maksim on 15/05/2022.
//

import Foundation

public enum TabBarState: Equatable {
    case fullyShown
    case onlyTab(Int)
    case hidden
}

public class TabBarStateManager: ObservableObject {
    
    @Published var state = TabBarState.fullyShown
    
    public func changeState(to newState: TabBarState) {
        state = newState
    }
}

