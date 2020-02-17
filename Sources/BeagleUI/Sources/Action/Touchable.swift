//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

public struct Touchable: ServerDrivenComponent {
    
    // MARK: - Public Properties
    
    public let action: Action
    public let child: ServerDrivenComponent
    
    // MARK: - Initialization
    
    public init(
        action: Action,
        child: ServerDrivenComponent
    ) {
        self.action = action
        self.child = child
    }
}

extension Touchable: Renderable {
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let childView = child.toView(context: context, dependencies: dependencies)
        context.register(action: action, inView: childView)
        prefetchComponent(context: context, dependencies: dependencies)
        return childView
    }
    
    private func prefetchComponent(context: BeagleContext, dependencies: RenderableDependencies) {
        guard let newPath = (action as? Navigate)?.newPath else { return }
        dependencies.preFetchHelper.prefetchComponent(newPath: newPath, dependencies: dependencies)
    }
}
