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
        
        widget.children.forEach {
            let childView = rendererProvider.buildRenderer(for: $0).buildView()
            containerView.addSubview(childView)
        }
        
        flexViewConfigurator.applyFlex(widget.flex, to: containerView)
        
        return containerView
    }
    
}
