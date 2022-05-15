//
//  TabBarSelection.swift
//  CustomTabView
//
//  Created by Maksim on 01/03/2022.
//

import SwiftUI

public class TabBarSelection<SelectionValue>: ObservableObject where SelectionValue: Hashable {
    
    @Binding public var selection: SelectionValue
    
    init(selection: Binding<SelectionValue>) {
        self._selection = selection
    }
}
