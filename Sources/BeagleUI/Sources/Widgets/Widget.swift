//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public protocol Widget {}

public protocol ComposeWidget: Widget {
    func build() -> Widget
}

extension Widget {
    func toView(
        context: BeagleContext,
        dependencies: ViewRenderer.Dependencies
    ) -> UIView {
        return dependencies.rendererProvider
            .buildRenderer(for: self, dependencies: dependencies)
            .buildView(context: context)
    }
}

// Defines a representation of an unknwon Widget
struct AnyWidget: Widget {
    let value: Any
}
