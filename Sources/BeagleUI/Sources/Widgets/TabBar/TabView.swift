//
//  TabView.swift
//  BeagleUI
//
//  Created by Gabriela Coelho on 20/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

public struct TabItem: Widget {

    public let icon: String?
    public let title: String?
    public let content: Widget
    
    public init(
        icon: String? = nil,
        title: String? = nil,
        content: Widget
    ) {
        self.icon = icon
        self.title = title
        self.content = content
    }
}

public struct TabView: Widget {
    public let tabItems: [TabItem]
    
    public init(
        tabItems: [TabItem]
    ) {
        self.tabItems = tabItems
    }
}
