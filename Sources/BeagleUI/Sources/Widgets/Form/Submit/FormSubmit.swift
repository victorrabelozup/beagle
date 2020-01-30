//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public struct FormSubmit: Widget {
    
    // MARK: - Public Properties
    
    public let child: Widget
    
    // MARK: - Initialization
    
    public init(
        child: Widget
    ) {
        self.child = child
    }
    
}

extension FormSubmit: Renderable {
    public func toView(context: BeagleContext, dependencies: Renderable.Dependencies) -> UIView {
        let childView = child.toView(context: context, dependencies: dependencies)
        childView.beagleFormElement = self
        return childView
    }
}
