//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public struct Button: Widget {
    
    // MARK: - Public Properties
    public let text: String
    public let style: String?
    public let action: Action?
    public var id: String?
    public let appearance: Appearance?
    public var accessibility: Accessibility?
    public let flex: Flex?
    
    public init(
        text: String,
        style: String? = nil,
        action: Action? = nil,
        id: String? = nil,
        appearance: Appearance? = nil,
        flex: Flex? = nil,
        accessibility: Accessibility? = nil
    ) {
        self.text = text
        self.style = style
        self.action = action
        self.id = id
        self.appearance = appearance
        self.flex = flex
        self.accessibility = accessibility
    }
}

extension Button: Renderable {
    
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        
        let button = BeagleUIButton.button(context: context, action: action, dependencies: dependencies)
        button.setTitle(text, for: .normal)
        
        if let newPath = (action as? Navigate)?.newPath {
            dependencies.preFetchHelper.prefetchComponent(newPath: newPath, dependencies: dependencies)
        }

        button.style = style
        button.applyAppearance(appearance)
        button.applyAccessibilityIdentifier(id)
        dependencies.accessibility.applyAccessibilityAttributes(accessibility, to: button)
        button.flex.setupFlex(flex)
        
        return button
    }
    
    final class BeagleUIButton: UIButton {
        
        var style: String? {
            didSet { applyStyle() }
        }
        
        override var isEnabled: Bool {
            get { return super.isEnabled }
            set {
                super.isEnabled = newValue
                applyStyle()
            }
        }
        
        override var isSelected: Bool {
            get { return super.isSelected }
            set {
                super.isSelected = newValue
                applyStyle()
            }
        }
        
        override var isHighlighted: Bool {
            get { return super.isHighlighted }
            set {
                super.isHighlighted = newValue
                applyStyle()
            }
        }
        
        private var action: Action?
        private weak var context: BeagleContext?
        private var dependencies: DependencyTheme?
        
        static func button(
            context: BeagleContext,
            action: Action?,
            dependencies: DependencyTheme
        ) -> BeagleUIButton {
            let button = BeagleUIButton(type: .system)
            button.action = action
            button.context = context
            button.dependencies = dependencies
            button.addTarget(button, action: #selector(triggerAction), for: .touchUpInside)
            return button
        }
        
        @objc func triggerAction() {
            guard let action = action else { return }
            context?.doAction(action, sender: self)
        }
        
        private func applyStyle() {
            guard let style = style else { return }
            dependencies?.theme.applyStyle(for: self as UIButton, withId: style)
        }
    }
    
}
