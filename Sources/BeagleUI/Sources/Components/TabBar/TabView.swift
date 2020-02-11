//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

public struct TabItem {

    public let icon: String?
    public let title: String?
    public let content: ServerDrivenComponent
    
    public init(
        icon: String? = nil,
        title: String? = nil,
        content: ServerDrivenComponent
    ) {
        self.icon = icon
        self.title = title
        self.content = content
    }
}

public struct TabView: ServerDrivenComponent {
    public let tabItems: [TabItem]
    
    public init(
        tabItems: [TabItem]
    ) {
        self.tabItems = tabItems
    }
}

extension TabView: Renderable {
    public func toView(context: BeagleContext, dependencies: Renderable.Dependencies) -> UIView {
        let model = TabViewUIComponent.Model(tabIndex: 0, tabViewItems: tabItems)
        let tabView = TabViewUIComponent(model: model)
        let flex = Flex(grow: 1)
        dependencies.flex.setupFlex(flex, for: tabView)
        return tabView
    }
}
