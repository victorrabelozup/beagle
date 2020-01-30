//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public struct Button: Widget {
    
    // MARK: - Public Properties
    
    public let text: String
    public let style: String?
    
    public init(
        text: String,
        style: String? = nil
    ) {
        self.text = text
        self.style = style
    }
}

extension Button: Renderable {
    public func toView(context: BeagleContext, dependencies: Renderable.Dependencies) -> UIView {
        let button = UIButton(type: .system)
        button.setTitle(text, for: .normal)
        
        if let style = style {
            dependencies.theme.applyStyle(for: button, withId: style)
        }
        
        return button
    }
}
