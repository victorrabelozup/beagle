//
//  ButtonWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Yan Dias on 08/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

final class ButtonWidgetViewRenderer: ViewRendering<Button> {
    
    // MARK: - Public Functions
    
    override func buildView(context: BeagleContext) -> UIView {
        
        let button = UIButton(type: .system)
        button.setTitle(widget.text, for: .normal)
        
        if let style = widget.style {
            self.theme.applyStyle(for: button, withId: style)
        }
        
        self.flex.enableYoga(true, for: button)
        button.sizeToFit()
        
        return button
    }
    
}
