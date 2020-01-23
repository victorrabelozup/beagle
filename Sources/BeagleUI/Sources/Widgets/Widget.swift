//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public protocol Widget {}

public protocol ComposeWidget: Widget {
    func build() -> Widget
}

extension Widget {

    public func toView(
        context: BeagleContext,
        dependencies: ViewRenderer.Dependencies
    ) -> UIView {
        return dependencies.rendererProvider
            .buildRenderer(for: self, dependencies: dependencies)
            .buildView(context: context)
    }

    public func toScreen() -> ScreenWidget {
        return (self as? ScreenWidget) ?? ScreenWidget(content: self)
    }
}

// Defines a representation of an unknwon Widget
public struct AnyWidget: Widget {
    public let value: Any
    
    public init(value: Any) {
        self.value = value
    }
}
