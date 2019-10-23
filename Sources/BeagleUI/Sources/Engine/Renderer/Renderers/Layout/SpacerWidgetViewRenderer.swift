//
//  SpacerWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 16/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

final class SpacerWidgetViewRenderer: WidgetViewRenderer<Spacer> {
    
    override func buildView() -> UIView {
        
        let flex = Flex(
            size: Flex.Size(
                width: UnitValue(value: widget.size, type: .real),
                height: UnitValue(value: widget.size, type: .real)
            )
        )
        
        let view = UIView()
        
        flexViewConfigurator.applyFlex(flex, to: view)
        flexViewConfigurator.applyYogaLayout(to: view, preservingOrigin: false)
        
        view.sizeToFit()
        
        return view
    }
    
}
