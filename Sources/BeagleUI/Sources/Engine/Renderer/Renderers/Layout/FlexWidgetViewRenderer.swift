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
    
    override func buildView(context: BeagleContext) -> UIView {
        
        let containerView = UIView()
        
        widget.children.forEach {
            let childView = self.rendererProvider
                .buildRenderer(for: $0, dependencies: dependencies)
                .buildView(context: context)
            containerView.addSubview(childView)
        }
        
        self.flex.setupFlex(widget.flex, for: containerView)
        
        return containerView
    }
    
}
