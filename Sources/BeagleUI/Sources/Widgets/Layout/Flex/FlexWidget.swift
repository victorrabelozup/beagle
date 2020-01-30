//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public struct FlexWidget: Widget, HasAppearance {
    
    // MARK: - Public Properties
    
    public let appearance: Appearance?
    public let children: [Widget]
    public let flex: Flex
    
    // MARK: - Initialization
    
    public init(
        children: [Widget],
        flex: Flex = Flex(),
        appearance: Appearance? = nil
    ) {
        self.children = children
        self.flex = flex
        self.appearance = appearance
    }
    
   // MARK: - Configuration
    
    public func applyFlex(_ flex: Flex) -> FlexWidget {
        return FlexWidget(children: children, flex: flex)
    }
    
}

extension FlexWidget: Renderable {
    public func toView(context: BeagleContext, dependencies: Renderable.Dependencies) -> UIView {
        let containerView = UIView()
        
        children.forEach {
            let childView = $0.toView(context: context, dependencies: dependencies)
            containerView.addSubview(childView)
            dependencies.flex.enableYoga(true, for: childView)
        }
        containerView.applyAppearance(appearance)
        dependencies.flex.setupFlex(flex, for: containerView)
        
        return containerView
    }
}
