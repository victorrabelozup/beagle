//
//  FlexSingleWidget.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 02/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

public struct FlexSingleWidget: Widget {
    
    public let child: Widget
    public let flex: Flex
    
    init(
        child: Widget,
        flex: Flex = Flex()
    ) {
        self.child = child
        self.flex = flex
    }
    
    public init(
        @WidgetBuilder _ childBuilder: () -> Widget
    ) {
        let child = childBuilder()
        self.init(child: child)
    }
    
    func applyFlex(_ flex: Flex = Flex()) -> FlexSingleWidget {
        return FlexSingleWidget(child: child, flex: flex)
    }
    
}
