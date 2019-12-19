//
//  FormInputWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Lucas Araújo on 18/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

final class FormInputWidgetViewRenderer: ViewRendering<FormInput> {
    
    // MARK: - Public Functions
    
    override func buildView(context: BeagleContext) -> UIView {
        let child = widget.child
        let childRenderer = self.rendererProvider.buildRenderer(for: child, dependencies: dependencies)
        let childView = childRenderer.buildView(context: context)
        childView.beagleFormElement = widget
        return childView
    }
    
}
