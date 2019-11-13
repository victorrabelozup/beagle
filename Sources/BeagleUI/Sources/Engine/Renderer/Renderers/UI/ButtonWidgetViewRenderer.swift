//
//  ButtonWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Yan Dias on 08/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

final class ButtonWidgetViewRenderer: WidgetViewRenderer<Button> {
    
    // MARK: - Public Functions
    
    override func buildView(context: BeagleContext) -> UIView {
        
        let button = UIButton(frame: .init(x: 0, y: 0, width: 100, height: 44))
        button.setTitle(widget.text, for: .normal)
        flexViewConfigurator.enableYoga(true, for: button)
        button.sizeToFit()
        
        return button
    }
    
}
