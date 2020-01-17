//
//  NavigationBar.swift
//  BeagleUI
//
//  Created by Gabriela Coelho on 18/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

public struct NavigationBar: Widget {
    
    // MARK: - Public Properties
    
    public let title: String
    public let leading: Widget?
    public let trailing: Widget?
    
    // MARK: - Initialization
    
    public init(
        title: String,
        leading: Widget? = nil,
        trailing: Widget? = nil
    ) {
        self.title = title
        self.leading = leading
        self.trailing = trailing
    }
}
