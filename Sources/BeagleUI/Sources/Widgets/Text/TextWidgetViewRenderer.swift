//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

final class TextWidgetViewRenderer: ViewRendering<Text> {
    
    override func buildView(context: BeagleContext) -> UIView {
        
        let label = UILabel(frame: .zero)
        label.text = widget.text
        label.numberOfLines = 0
        label.textAlignment = widget.alignment?.toUIKit() ?? .natural
        if let style = widget.style {
            dependencies.theme.applyStyle(for: label, withId: style)
        }
        label.applyAppearance(widget.appearance)
        
        return label
    }
    
}
