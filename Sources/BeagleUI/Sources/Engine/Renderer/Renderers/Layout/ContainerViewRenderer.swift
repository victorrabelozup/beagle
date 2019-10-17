//
//  ContainerViewRenderer.swift
//  BeagleUI
//
//  Created by Daniel Tes on 16/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

final class ContainerViewRenderer: WidgetViewRenderer<Container> {
    
    // MARK: - Public Functions
    
    override func buildView() -> UIView {
        let view = UIView(frame: .zero)
        let flex = Flex(flexDirection: .column, justifyContent: .spaceBetween)
        
        if let header = widget.header {
            let headerView = rendenrerProvider.buildRenderer(for: header).buildView()
            view.addSubview(headerView)
        }
        
        let scrollView = contentScrollView()
        view.addSubview(scrollView)
        
        if let footer = widget.footer {
            let footerView = rendenrerProvider.buildRenderer(for: footer).buildView()
            view.addSubview(footerView)
        }
        
        flexViewConfigurator.applyFlex(flex, to: view)
        return view
    }
    
    // MARK: - Private Functions
    
    private func contentScrollView() -> UIScrollView {
        let scrollView = UIScrollView(frame: .zero)
        let flex = Flex(grow: 1)
        
        let contentView = rendenrerProvider.buildRenderer(for: widget.content).buildView()
        scrollView.addSubview(contentView)
        
        flexViewConfigurator.configFlex(flex, to: scrollView)
        return scrollView
    }
}
