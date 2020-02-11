//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

 public struct LazyComponent: ServerDrivenComponent {
    
    // MARK: - Public Properties
    
    public let url: String
    public let initialState: ServerDrivenComponent
        
    // MARK: - Initialization
    
    public init(
        url: String,
        initialState: ServerDrivenComponent
    ) {
        self.url = url
        self.initialState = initialState
    }
}

extension LazyComponent: Renderable {
    public func toView(context: BeagleContext, dependencies: Renderable.Dependencies) -> UIView {
        let view = initialState.toView(context: context, dependencies: dependencies)
        context.lazyLoad(url: url, initialState: view)
        return view
    }
}
