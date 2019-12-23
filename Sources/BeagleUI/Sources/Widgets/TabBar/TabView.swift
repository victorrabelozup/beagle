//
//  TabView.swift
//  BeagleUI
//
//  Created by Gabriela Coelho on 20/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

public struct TabItem: NativeWidget {
    public let icon: String?
    public let title: String?
    public let content: Widget
    
    init(
        icon: String? = nil,
        title: String? = nil,
        content: Widget
    ) {
        self.icon = icon
        self.title = title
        self.content = content
    }
    
    public init(
        icon: String? = nil,
        title: String? = nil,
        @WidgetBuilder content contentBuilder: () -> Widget
    ) {
        let singleContent = contentBuilder()
        self.init(icon: icon, title: title, content: singleContent)
    }
}

public struct TabView: NativeWidget {
    public let tabItems: [TabItem]
    
    public init(
        tabItems: [TabItem]
    ) {
        self.tabItems = tabItems
    }
}
