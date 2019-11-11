//
//  ScrollViewWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Tarcisio Clemente on 06/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

import YogaKit

final class ScrollViewWidgetViewRenderer: WidgetViewRenderer<ScrollView> {
    
    // MARK: - Public Functions
    
    override func buildView() -> UIScrollView {

        let scrollView = buildContentScrollView()
        scrollView.backgroundColor = .green
        
        flexViewConfigurator.setupFlex(Flex(), for: scrollView)
        
        return scrollView
    }
    
    // MARK: - Private Functions
    
    private func buildContentScrollView() -> UIScrollView {
        
        let scrollView = BeagleContainerScrollView()
        let flex = Flex(grow: 1)
        let contentView = UIView()
        
        widget.children.forEach {
            let childView = rendererProvider.buildRenderer(for: $0).buildView()
            contentView.addSubview(childView)
        }
        
        scrollView.addSubview(contentView)
        
        let flexContent = Flex(grow: 1, shrink: 0)
        
        flexViewConfigurator.setupFlex(flex, for: scrollView)
        flexViewConfigurator.setupFlex(flexContent, for: contentView)
        
        return scrollView
    }
    
}
