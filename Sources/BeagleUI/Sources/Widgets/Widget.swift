//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public protocol Widget: Renderable {}

public protocol ComposeWidget: Widget {
    func build() -> Widget
}

public protocol Renderable {
    typealias Dependencies =
        DependencyFlexViewConfigurator
        & DependencyTheme
        & DependencyValidatorProvider
        & DependencyPreFetching
        & DependencyAppBundle
        & DependencyNetwork
    
    func toView(context: BeagleContext, dependencies: Renderable.Dependencies) -> UIView
}

extension Widget {
    public func toScreen() -> ScreenWidget {
        return (self as? ScreenWidget)
        ?? ScreenWidget(
            safeArea: SafeArea(top: true, leading: true, bottom: true, trailing: true),
            content: self
        )
    }
}

// Defines a representation of an unknwon Widget
public struct AnyWidget: Widget {
    public let value: Any
    
    public init(value: Any) {
        self.value = value
    }
}

extension AnyWidget: Renderable {
    public func toView(context: BeagleContext, dependencies: Renderable.Dependencies) -> UIView {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 2
        label.text = "Unknown Widget of type:\n \(String(describing: value))"
        label.textColor = .red
        label.backgroundColor = .yellow
        return label
    }
}
