//
//  NavigationBar.swift
//  BeagleUI
//
//  Created by Gabriela Coelho on 18/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

public struct NavigationBar: NativeWidget {
    
    // MARK: - Public Properties
    
    public let title: String
    public let leading: Widget?
    public let trailing: Widget?
    
    // MARK: - Initialization

    init(
        title: String,
        leading: Widget? = nil,
        trailing: Widget? = nil
    ) {
        self.title = title
        self.leading = leading
        self.trailing = trailing
    }

    public init(
         title: String,
         @WidgetBuilder leading leadingBuilder: () -> Widget,
         @WidgetBuilder trailing trailingBuilder: () -> Widget
    ) {
        self.title = title
        self.leading = leadingBuilder()
        self.trailing = trailingBuilder()
    }
}
