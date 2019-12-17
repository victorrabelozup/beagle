//
//  Widget.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation
import UIKit

/// Defines some component that can be rendered on a Screen
public protocol Widget {
    func build() throws -> Widget
}

/// Defines some component that can be rendered on a Screen
public protocol NativeWidget: Widget {}
extension NativeWidget {
    public func build() throws -> Widget {
        throw unbuildableWidgetError
    }
}

extension Widget {

    func toView(
        context: BeagleContext,
        dependencies: RendererDependencies = Beagle.dependencies
    ) -> UIView {
        return dependencies.rendererProvider
            .buildRenderer(for: self, dependencies: dependencies)
            .buildView(context: context)
    }
}

private let unbuildableWidgetError = NSError(
    domain: "Widget",
    code: -1,
    description: "NativeWidgets don't need to be built!"
)

// Defines a representation of an unknwon Widget
struct AnyWidget: Widget {
    
    let value: Any
    
    func build() throws -> Widget {
        guard let buildable = value as? Widget else {
            throw unbuildableWidgetError
        }
        
        return try buildable.build()
    }
    
}
