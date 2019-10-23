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
    
    override func buildView() -> UIView {
        
        let button = UIButton(frame: .zero)
        button.setTitle(widget.text, for: .normal)
        
        flexViewConfigurator.enableYoga(true, for: button) // TODO: Remove-me? For tests.
        
        button.sizeToFit()
        
        return button
    }
    
}
