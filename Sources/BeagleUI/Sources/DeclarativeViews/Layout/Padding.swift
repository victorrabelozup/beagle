//
//  Padding.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

public struct Padding: NativeWidget {
    
    // MARK: - Public Properties
    
    public let value: Value
    public let child: Widget
    
    // MARK: - Initialization
    
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

// MARK: - PaddingValue
extension Padding {
    
    public struct Value {
        
        // MARK: - Static
        
        public static let zero = Value()
        
        // MARK: - Public Properties
        
        public let top: UnitValue?
        public let left: UnitValue?
        public let right: UnitValue?
        public let bottom: UnitValue?
        
        // MARK: - Initialization
        
        public init(
            top: UnitValue = .zero,
            left: UnitValue? = .zero,
            right: UnitValue? = .zero,
            bottom: UnitValue? = .zero
        ) {
            self.top = top
            self.left = left
            self.right = right
            self.bottom = bottom
        }
        
    }
    
}
