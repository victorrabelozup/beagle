//
//  Padding.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

public struct Padding: Widget {
    
    public let value: Value
    public let child: Widget
    
    init(
        value: Value,
        child: Widget
    ) {
        self.value = value
        self.child = child
    }
    
    public init(
        value: Value = Value(),
        @WidgetBuilder child childBuilder: () -> Widget
    ) {
        self.value = value
        self.child = childBuilder()
    }
    
}
extension Padding {
    public struct Value {
        
        public let top: UnitValue?
        public let left: UnitValue?
        public let right: UnitValue?
        public let bottom: UnitValue?
        
        public init(
            top: UnitValue = .default,
            left: UnitValue? = .default,
            right: UnitValue? = .default,
            bottom: UnitValue? = .default
        ) {
            self.top = top
            self.left = left
            self.right = right
            self.bottom = bottom
        }
        
    }
}
