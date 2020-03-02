//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public struct Container: Widget {
    
    // MARK: - Public Properties
    public let children: [ServerDrivenComponent]
    
    public var id: String?
    public let flex: Flex?
    public let appearance: Appearance?
    public let accessibility: Accessibility?
    
    // MARK: - Initialization
    
    public init(
        children: [ServerDrivenComponent],
        id: String? = nil,
        flex: Flex? = nil,
        appearance: Appearance? = nil,
        accessibility: Accessibility? = nil
    ) {
        self.children = children
        self.id = id
        self.flex = flex
        self.appearance = appearance
        self.accessibility = accessibility
    }
    
   // MARK: - Configuration
    
    public func applyFlex(_ flex: Flex) -> Container {
        return Container(children: children, flex: flex, appearance: appearance)
    }
}

extension Container: Renderable {
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let containerView = UIView()
        
        children.forEach {
            let childView = $0.toView(context: context, dependencies: dependencies)
            containerView.addSubview(childView)
            childView.flex.isEnabled = true
        }
        
        containerView.applyAccessibilityIdentifier(id)
        containerView.applyAppearance(appearance)
        containerView.flex.setupFlex(flex)
        dependencies.accessibility.applyAccessibilityAttributes(accessibility, to: containerView)
        
        return containerView
    }
}
