//
//  DropDown.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

public struct DropDown: Widget {
    
    let header: Widget
    let child: Widget
    
    init(
        header: Widget,
        child: Widget
    ) {
        self.header = header
        self.child = child
    }
    
    public init(
        header headerBuilder: () -> Widget,
        child childBuilder: () -> Widget
    ) {
        header = headerBuilder()
        child = childBuilder()
    }
    
}
