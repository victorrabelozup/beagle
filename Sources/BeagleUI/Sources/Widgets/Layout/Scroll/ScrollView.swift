//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import Foundation

public struct ScrollView: Widget, HasAppearance {
    
    // MARK: - Public Properties
    
    public let children: [Widget]
    public let appearance: Appearance?
    
    // MARK: - Initialization
    
    init(
        children: [Widget] = [],
        appearance: Appearance? = nil
    ) {
        self.children = children
        self.appearance = appearance
    }
    
    public init(
        appearance: Appearance? = nil,
        @WidgetBuilder _ childBuilder: () -> Widget
    ) {
        let singleChild = childBuilder()
        self.init(children: [singleChild], appearance: appearance)
    }
    
    public static func new(
        appearance: Appearance? = nil,
        closure: () -> Widget
    ) -> ScrollView {
        let singleChild = closure()
        return .init(children: [singleChild], appearance: appearance)
    }
    
    public init(
        appearance: Appearance? = nil,
        @WidgetArrayBuilder _ childrenBuilder: () -> [Widget]
    ) {
        let children = childrenBuilder()
        self.init(children: children, appearance: appearance)
    }
    
    public static func new(
        appearance: Appearance? = nil,
        closure: () -> [Widget]
    ) -> ScrollView {
        let children = closure()
        return .init(children: children, appearance: appearance)
    }
    
}
