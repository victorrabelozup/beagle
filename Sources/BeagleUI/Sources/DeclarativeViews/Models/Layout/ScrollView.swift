//
//  ScrollView.swift
//  BeagleUI
//
//  Created by Tarcisio Clemente on 06/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

public struct ScrollView: NativeWidget {
    
    // MARK: - Public Properties
    
    public let children: [Widget]
    
    // MARK: - Initialization
    
    init(
        children: [Widget] = [],
        reversed: Bool = false
    ) {
        self.children = children
    }
    
    public init(
        @WidgetBuilder _ childBuilder: () -> Widget
    ) {
        let singleChild = childBuilder()
        self.init(children: [singleChild])
    }
    
    public static func new(
        closure: () -> Widget
    ) -> ScrollView {
        let singleChild = closure()
        return .init(children: [singleChild])
    }
    
    public init(
        @WidgetArrayBuilder _ childrenBuilder: () -> [Widget]
    ) {
        let children = childrenBuilder()
        self.init(children: children)
    }
    
    public static func new(
        closure: () -> [Widget]
    ) -> ScrollView {
        let children = closure()
        return .init(children: children)
    }
    
}
