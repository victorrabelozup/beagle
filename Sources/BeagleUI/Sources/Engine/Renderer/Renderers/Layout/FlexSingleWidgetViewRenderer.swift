//
//  FlexSingleWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Daniel Tes on 16/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

final class FlexSingleWidgetViewRenderer: WidgetViewRenderer<FlexSingleWidget> {
    
    // MARK: - Public Functions
    
    override func buildView() -> UIView {
        
        let child = widget.child
        let childRenderer = rendererProvider.buildRenderer(for: child)
        let childView = childRenderer.buildView()
        
        let view = UIView()
        view.addSubview(childView)
        
        flexViewConfigurator.setupFlex(widget.flex, for: view)
        
        return view
    }
}
