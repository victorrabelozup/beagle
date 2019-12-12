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
    
    override func buildView(context: BeagleContext) -> UIView {
        
        let child = widget.child
        let childRenderer = self.rendererProvider.buildRenderer(for: child, dependencies: dependencies)
        let childView = childRenderer.buildView(context: context)
        
        let view = UIView()
        view.addSubview(childView)
        
        self.flex.setupFlex(widget.flex, for: view)
        
        return view
    }
}
