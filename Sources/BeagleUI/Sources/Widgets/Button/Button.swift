//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public struct Button: Widget {
    
    // MARK: - Public Properties
    public let text: String
    public let style: String?
    public let action: Action?
    
    public init(
        text: String,
        style: String? = nil,
        action: Action? = nil
    ) {
        self.text = text
        self.style = style
        self.action = action
    }
}

extension Button: Renderable {
    
    public func toView(context: BeagleContext, dependencies: Renderable.Dependencies) -> UIView {
        
        let button = BeagleUIButton.button(context: context, action: action)
        button.setTitle(text, for: .normal)
        
        if let prefechableData = (action as? Navigate)?.prefechableData {
            dependencies.preFetchHelper.prefetchWidget(path: prefechableData.path)
        }
        if let style = style {
            button.style = style
            dependencies.theme.applyStyle(for: button as UIButton, withId: style)
        }
        return button
    }
    
    final class BeagleUIButton: UIButton {
        
        var style: String?
        private var action: Action?
        private weak var context: BeagleContext?
        
        static func button(context: BeagleContext, action: Action?) -> BeagleUIButton {
            let button = BeagleUIButton(type: .system)
            button.action = action
            button.context = context
            button.addTarget(button, action: #selector(triggerAction), for: .touchUpInside)
            return button
        }
        
        @objc func triggerAction() {
            guard let action = action else { return }
            context?.doAction(action, sender: self)
        }
    }
    
}
