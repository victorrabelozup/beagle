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
    
    override func buildView() -> UIView {

        let view = UIView()
        if let header = widget.header {
            let renderer = rendererProvider.buildRenderer(for: header)
            let headerView = renderer.buildView()
            headerView.backgroundColor = .red
            view.addSubview(headerView)
        }
        
        let scrollView = buildContentScrollView()
        scrollView.backgroundColor = .green
        view.addSubview(scrollView)
        
        if let footer = widget.footer {
            let renderer = rendererProvider.buildRenderer(for: footer)
            let footerView = renderer.buildView()
            footerView.backgroundColor = .gray
            view.addSubview(footerView)
        }
        flexViewConfigurator.setupFlex(Flex(), for: view)
        
        return view
    }
    
    // MARK: - Private Functions
    
    private func buildContentScrollView() -> UIScrollView {
        
        let scrollView = ContainerScrollView()
        let flex = Flex(grow: 1)
        let contentView = rendererProvider.buildRenderer(for: widget.content).buildView()
        scrollView.addSubview(contentView)
        
        flexViewConfigurator.setupFlex(flex, for: scrollView)
        
        return scrollView
    }
    
}

private class ContainerScrollView: UIScrollView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if let contentView = subviews.first {
            contentSize = contentView.frame.size
        }
    }
}
