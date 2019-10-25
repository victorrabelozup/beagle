//
//  FlexWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Daniel Tes on 16/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit
import YogaKit

final class FlexWidgetViewRenderer: WidgetViewRenderer<FlexWidget> {
    
    // MARK: - Public Functions
    
    override func buildView() -> UIView {
        
        let containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        widget.children.forEach {
            let childView = rendererProvider.buildRenderer(for: $0).buildView()
            containerView.addSubview(childView)
        }
        
        flexViewConfigurator.setupFlex(widget.flex, for: containerView)
        
        return containerView
    }
    
}
