//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

 public struct LazyWidget: Widget {
    
    // MARK: - Public Properties
    
    public let url: String
    public let initialState: Widget
        
    // MARK: - Initialization
    
    public init(
        url: String,
        initialState: Widget
    ) {
        self.url = url
        self.initialState = initialState
    }
}

extension LazyWidget: Renderable {
    public func toView(context: BeagleContext, dependencies: Renderable.Dependencies) -> UIView {
        let view = initialState.toView(context: context, dependencies: dependencies)
        context.lazyLoad(url: url, initialState: view)
        return view
    }
}
