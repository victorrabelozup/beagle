//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public struct FormInput: ServerDrivenComponent {
    
    public let name: String
    public let required: Bool?
    public let validator: String?
    public let errorMessage: String?
    public let child: ServerDrivenComponent

    public init(
        name: String,
        required: Bool? = nil,
        validator: String? = nil,
        errorMessage: String? = nil,
        child: ServerDrivenComponent
    ) {
        self.name = name
        self.required = required
        self.validator = validator
        self.errorMessage = errorMessage
        self.child = child
    }
    
}

extension FormInput: Renderable {
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let childView = child.toView(context: context, dependencies: dependencies)
        childView.beagleFormElement = self
        return childView
    }
}
