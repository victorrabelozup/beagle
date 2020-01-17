//
//  TabViewWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Gabriela Coelho on 25/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

final class TabViewRenderer: ViewRendering<TabView> {
    
    override func buildView(context: BeagleContext) -> UIView {
        let model = TabViewUIComponent.Model(tabIndex: 0, tabViewItems: widget.tabItems)
        let tabView = TabViewUIComponent(model: model)
        let flex = Flex(grow: 1)
        dependencies.flex.setupFlex(flex, for: tabView)
        dependencies.flex.enableYoga(true, for: tabView)
        return tabView
    }
}
