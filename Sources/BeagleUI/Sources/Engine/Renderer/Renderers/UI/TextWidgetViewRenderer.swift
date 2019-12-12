//
//  TextWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Gabriela Coelho on 08/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

final class TextWidgetViewRenderer: WidgetViewRenderer<Text> {
    
    override func buildView(context: BeagleContext) -> UIView {
        
        let label = UILabel(frame: .zero)
        label.text = widget.text
        label.numberOfLines = 0
        label.textAlignment = widget.alignment?.toUIKit() ?? .natural
        if let style = widget.style {
            self.theme.applyStyle(for: label, withId: style)
        }
        
        self.flex.enableYoga(true, for: label)
        
        return label
    }
    
}
