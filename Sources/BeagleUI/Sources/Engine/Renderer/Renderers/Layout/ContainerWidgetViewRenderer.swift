//
//  ContainerViewRenderer.swift
//  BeagleUI
//
//  Created by Daniel Tes on 16/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit
import YogaKit

final class ContainerWidgetViewRenderer: WidgetViewRenderer<Container> {
    
    // MARK: - Public Functions
    
    override func buildView(context: BeagleContext) -> UIView {

        let view = UIView()
        if let header = widget.header {
            let renderer = rendererProvider.buildRenderer(for: header)
            let headerView = renderer.buildView(context: context)
            view.addSubview(headerView)
        }
        
        let scrollView = buildContentScrollView(context: context)
        view.addSubview(scrollView)
        
        if let footer = widget.footer {
            let renderer = rendererProvider.buildRenderer(for: footer)
            let footerView = renderer.buildView(context: context)
            view.addSubview(footerView)
        }
        flexViewConfigurator.setupFlex(Flex(), for: view)
        
        return view
    }
    
    // MARK: - Private Functions
    
    private func buildContentScrollView(context: BeagleContext) -> UIScrollView {
        
        let scrollView = BeagleContainerScrollView()
        let flex = Flex(grow: 1)
        let contentView = rendererProvider.buildRenderer(for: widget.content).buildView(context: context)
        scrollView.addSubview(contentView)
        
        flexViewConfigurator.setupFlex(flex, for: scrollView)
        
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
