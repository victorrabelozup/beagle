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
        let view = UIView()
        
        let childView = rendenrerProvider.buildRenderer(for: widget).buildView()
        view.addSubview(childView)
        
        flexViewConfigurator.applyFlex(widget.flex, to: view)
        return view
    }
}
