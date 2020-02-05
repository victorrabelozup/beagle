//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

public struct Touchable: Widget {
    
    // MARK: - Public Properties
    
    public let action: Action
    public let child: Widget
    
    // MARK: - Initialization
    
    public init(
        action: Action,
        child: Widget
    ) {
        self.action = action
        self.child = child
    }
}

extension Touchable: Renderable {
    public func toView(context: BeagleContext, dependencies: Renderable.Dependencies) -> UIView {
        let childView = child.toView(context: context, dependencies: dependencies)
        context.register(action: action, inView: childView)
        prefetchWidget(context: context)
        return childView
    }
    
    private func prefetchWidget(context: BeagleContext) {
        guard let prefetch = (action as? Navigate)?.isPrefetchable() else { return }
        
        Beagle.dependencies.preFetchHelper.prefetchWidget(path: prefetch.path)
    }
}
