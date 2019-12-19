//
//  ScrollViewWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Tarcisio Clemente on 06/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

import YogaKit

final class ScrollViewWidgetViewRenderer: ViewRendering<ScrollView> {
    
    // MARK: - Public Functions
    
    override func buildView(context: BeagleContext) -> UIScrollView {

        let scrollView = buildContentScrollView(context: context)
        scrollView.backgroundColor = .green
        
        self.flex.setupFlex(Flex(), for: scrollView)
        
        return scrollView
    }
    
    // MARK: - Private Functions
    
    private func buildContentScrollView(context: BeagleContext) -> UIScrollView {
        
        let scrollView = BeagleContainerScrollView()
        let flex = Flex(grow: 1)
        let contentView = UIView()
        
        widget.children.forEach {
            let childView = self.rendererProvider
                .buildRenderer(for: $0, dependencies: dependencies)
                .buildView(context: context)
            contentView.addSubview(childView)
        }
        
        scrollView.addSubview(contentView)
        
        let flexContent = Flex(grow: 1, shrink: 0)
        
        self.flex.setupFlex(flex, for: scrollView)
        self.flex.setupFlex(flexContent, for: contentView)
        
        return scrollView
    }
    
}
