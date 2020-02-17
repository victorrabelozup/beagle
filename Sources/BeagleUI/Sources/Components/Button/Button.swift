//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public struct Button: Widget {
    
    // MARK: - Public Properties
    public let text: String
    public let style: String?
    public let action: Action?
    
    public let appearance: Appearance?
    public let flex: Flex?
    
    public init(
        text: String,
        style: String? = nil,
        action: Action? = nil,
        appearance: Appearance? = nil,
        flex: Flex? = nil
    ) {
        self.text = text
        self.style = style
        self.action = action
        self.appearance = appearance
        self.flex = flex
    }
}

extension Button: Renderable {
    
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        
        let button = BeagleUIButton.button(context: context, action: action)
        button.setTitle(text, for: .normal)
        
        if let newPath = (action as? Navigate)?.newPath {
            dependencies.preFetchHelper.prefetchComponent(newPath: newPath, dependencies: dependencies)
        }
        if let style = style {
            button.style = style
            dependencies.theme.applyStyle(for: button as UIButton, withId: style)
        }
        
        button.applyAppearance(appearance)
        dependencies.flex.setupFlex(flex, for: button)
        
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
