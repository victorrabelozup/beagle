//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public struct FlexSingleWidget: Widget, HasAppearance {
    
    // MARK: - Public Properties
    
    public let appearance: Appearance?
    public let child: Widget
    public let flex: Flex
    
    // MARK: - Initialization
    
    public init(
        child: Widget,
        flex: Flex = Flex(),
        appearance: Appearance? = nil
    ) {
        self.child = child
        self.flex = flex
        self.appearance = appearance
    }
    
    // MARK: - Configuration
    
    public func apply(_ flex: Flex) -> FlexSingleWidget {
        return FlexSingleWidget(child: child, flex: flex)
    }
    
}

extension FlexSingleWidget: Renderable {
    public func toView(context: BeagleContext, dependencies: Renderable.Dependencies) -> UIView {
        let childView = child.toView(context: context, dependencies: dependencies)
        let view = UIView()
        view.addSubview(childView)
        view.applyAppearance(appearance)
        
        dependencies.flex.enableYoga(true, for: childView)
        dependencies.flex.setupFlex(flex, for: view)
        
        return view
    }
}
