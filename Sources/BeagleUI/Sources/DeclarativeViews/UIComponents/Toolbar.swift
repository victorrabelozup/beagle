//
//  Toolbar.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

public struct ToolBar: Widget {
    
    public let title: String
    public let showBackButton: Bool
    
    public init(
        title: String,
        showBackButton: Bool = true
    ) {
        self.title = title
        self.showBackButton = showBackButton
    }
    
}
