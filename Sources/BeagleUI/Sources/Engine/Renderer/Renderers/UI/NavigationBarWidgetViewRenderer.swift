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
        let navigationBarItemTitle = UINavigationItem(title: widget.title)
        navigationBar.items = [navigationBarItemTitle]
        navigationBar.sizeToFit()
        flexViewConfigurator.enableYoga(true, for: navigationBar)
        return navigationBar
    }
    
}
