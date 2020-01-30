//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

public struct Navigator: Widget {
    
    // MARK: - Public Properties
    
    public let action: Navigate
    public let child: Widget
    
    // MARK: - Initialization
    
    public init(
        action: Navigate,
        child: Widget
    ) {
        self.action = action
        self.child = child
    }
}

extension Navigator: Renderable {
    public func toView(context: BeagleContext, dependencies: Renderable.Dependencies) -> UIView {
        let childView = child.toView(context: context, dependencies: dependencies)
        context.register(action: action, inView: childView)
        prefetchWidget(context: context)
        return childView
    }
    
    private func prefetchWidget(context: BeagleContext) {
        guard let prefetch = action.isPrefetchable() else { return }
        
        Beagle.dependencies.preFetchHelper.prefetchWidget(path: prefetch.path)
    }
}
