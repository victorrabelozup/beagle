//
//  FlexSingleWidget.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 02/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

public struct FlexSingleWidget: NativeWidget {
    
    // MARK: - Public Properties
    
    public let child: Widget
    public let flex: Flex
    
    // MARK: - Initialization
    
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
    
    // MARK: - Configuration
    
    public func applyFlex(
        direction: Flex.Direction? = nil,
        flexDirection: Flex.FlexDirection? = nil,
        flexWrap: Flex.Wrap? = nil,
        justifyContent: Flex.JustifyContent? = nil,
        alignItems: Flex.Alignment? = nil,
        alignSelf: Flex.Alignment? = nil,
        alignContent: Flex.Alignment? = nil,
        basis: UnitValue? = nil,
        flex: Double? = nil,
        grow: Double? = nil,
        shrink: Double? = nil,
        display: Flex.Display? = nil,
        size: Flex.Size? = nil,
        margin: Flex.EdgeValue? = nil,
        padding: Flex.EdgeValue? = nil,
        position: Flex.EdgeValue? = nil
    ) -> FlexSingleWidget {
        let flex = Flex(
            direction: direction,
            flexDirection: flexDirection,
            flexWrap: flexWrap,
            justifyContent: justifyContent,
            alignItems: alignItems,
            alignSelf: alignItems,
            alignContent: alignContent,
            basis: basis,
            flex: flex,
            grow: grow,
            shrink: shrink,
            display: display,
            size: size,
            margin: margin,
            padding: padding,
            position: position
        )
        return FlexSingleWidget(child: child, flex: flex)
    }
    
}
