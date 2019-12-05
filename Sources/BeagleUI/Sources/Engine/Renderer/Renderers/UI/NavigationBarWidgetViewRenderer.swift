//
//  NavigationBarWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Gabriela Coelho on 18/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

final class NavigationBarWidgetViewRenderer: WidgetViewRenderer<NavigationBar> {
    
    // MARK: - Public Functions
    
    override func buildView(context: BeagleContext) -> UIView {
        let navigationBar = UINavigationBar(frame: .zero)
        let navigationItems = UINavigationItem(title: widget.title)
        
        if let leading = widget.leading {
            let renderer = rendererProvider.buildRenderer(for: leading)
            let leadingView = renderer.buildView(context: context)
            leadingView.sizeToFit()
            navigationItems.leftBarButtonItem = UIBarButtonItem(customView: leadingView)
        }
        
        if let trailing = widget.trailing {
            let renderer = rendererProvider.buildRenderer(for: trailing)
            let trailingView = renderer.buildView(context: context)
            trailingView.sizeToFit()
            navigationItems.rightBarButtonItem = UIBarButtonItem(customView: trailingView)
        }
        navigationBar.items = [navigationItems]
        navigationBar.isTranslucent = false
        navigationBar.sizeToFit()
        flexViewConfigurator.enableYoga(true, for: navigationBar)
        return navigationBar
    }
}
