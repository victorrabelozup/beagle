//
//  TextWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Gabriela Coelho on 08/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

final class TextWidgetViewRenderer: BaseWidgetViewRenderer<Text> {
    
    override func buildView() -> UIView {
        let label = UILabel(frame: .zero)
        label.text = widget.text
        return label
    }
    
}
