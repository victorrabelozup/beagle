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
    
    public init(
        title: String,
        @WidgetBuilder leading leadingBuilder: () -> Widget
    ) {
        self.init(title: title, leading: leadingBuilder())
    }
    
    public init(
        title: String,
        @WidgetBuilder trailing trailingBuilder: () -> Widget
    ) {
        self.init(title: title, trailing: trailingBuilder())
    }
    
}
