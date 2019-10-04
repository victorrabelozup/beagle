//
//  Toolbar.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

public struct ToolBar: UIComponentWidget {
    
    // MARK: - Public Properties
    
    public let title: String
    public let showBackButton: Bool
    
    // MARK: - Initialization
    
    public init(
        title: String,
        showBackButton: Bool = true
    ) {
        self.title = title
        self.showBackButton = showBackButton
    }
    
}
