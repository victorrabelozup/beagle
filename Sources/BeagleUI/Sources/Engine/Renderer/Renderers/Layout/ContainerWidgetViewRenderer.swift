//
//  ContainerViewRenderer.swift
//  BeagleUI
//
//  Created by Daniel Tes on 16/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit
import YogaKit

final class ContainerWidgetViewRenderer: ViewRendering<Container> {
    
    // MARK: - Public Functions
    
    override func buildView(context: BeagleContext) -> UIView {

        let view = UIView()
        if let header = widget.header {
            let renderer = self.rendererProvider.buildRenderer(for: header, dependencies: dependencies)
            let headerView = renderer.buildView(context: context)
            view.addSubview(headerView)
        }
        
        let scrollView = buildContentScrollView(context: context)
        view.addSubview(scrollView)
        
        if let footer = widget.footer {
            let renderer = self.rendererProvider.buildRenderer(for: footer, dependencies: dependencies)
            let footerView = renderer.buildView(context: context)
            view.addSubview(footerView)
        }
        self.flex.setupFlex(Flex(), for: view)
        
        return view
    }
    
    // MARK: - Private Functions
    
    private func buildContentScrollView(context: BeagleContext) -> UIScrollView {
        
        let scrollView = BeagleContainerScrollView()
        let flex = Flex(grow: 1)
        let contentView = self.rendererProvider
            .buildRenderer(for: widget.content, dependencies: dependencies)
            .buildView(context: context)
        scrollView.addSubview(contentView)
        
        self.flex.setupFlex(flex, for: scrollView)
        
        return scrollView
    }
}

final class BeagleContainerScrollView: UIScrollView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if let contentView = subviews.first {
            contentSize = contentView.frame.size
        }
    }
}
