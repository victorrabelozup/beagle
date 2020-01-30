//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public struct FormInput: Widget {
    
    public let name: String
    public let required: Bool?
    public let validator: String?
    public let errorMessage: String?
    public let child: Widget

    public init(
        name: String,
        required: Bool? = nil,
        validator: String? = nil,
        errorMessage: String? = nil,
        child: Widget
    ) {
        self.name = name
        self.required = required
        self.validator = validator
        self.errorMessage = errorMessage
        self.child = child
    }
    
}

extension FormInput: Renderable {
    public func toView(context: BeagleContext, dependencies: Renderable.Dependencies) -> UIView {
        let childView = child.toView(context: context, dependencies: dependencies)
        childView.beagleFormElement = self
        return childView
    }
}
