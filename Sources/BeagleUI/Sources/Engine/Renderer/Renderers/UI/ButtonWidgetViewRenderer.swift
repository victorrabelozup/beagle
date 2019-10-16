//
//  ButtonWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Yan Dias on 08/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

final class ButtonWidgetViewRenderer: BaseWidgetViewRenderer<Button> {
    
    // MARK: - Public Functions
    
    override func buildView() -> UIView {
        let button = UIButton(frame: .zero)
        button.setTitle(widget.text, for: .normal)
        return button
    }
    
}
