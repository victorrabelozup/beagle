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
        
        let frame = CGRect(x: 0, y: 0, width: screenSizeProvider.size.width, height: screenSizeProvider.size.height)
        let view = UIView(frame: frame)
        let flex = Flex(flexDirection: .column, justifyContent: .spaceBetween)
        
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
        
        flexViewConfigurator.setupFlex(flex, for: view)
        
        view.sizeToFit()
        
        return view
    }
    
    // MARK: - Private Functions
    
    private func buildContentScrollView() -> UIScrollView {
        
        let scrollView = UIScrollView(frame: .zero)
        
        let flex = Flex(grow: 1)
        
        let contentView = rendererProvider.buildRenderer(for: widget.content).buildView()
        scrollView.addSubview(contentView)
        
        flexViewConfigurator.setupFlex(flex, for: scrollView)
        
        return scrollView
    }
    
}
