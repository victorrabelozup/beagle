//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public protocol ServerDrivenComponent: Renderable {}

public protocol ComposeComponent: ServerDrivenComponent {
    func build() -> ServerDrivenComponent
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

extension ServerDrivenComponent {
    public func toScreen() -> ScreenComponent {
        return (self as? ScreenComponent)
        ?? ScreenComponent(
            safeArea: SafeArea(top: true, leading: true, bottom: true, trailing: true),
            content: self
        )
    }
}

// Defines a representation of an unknwon Component
public struct AnyComponent: ServerDrivenComponent {
    public let value: Any
    
    public init(value: Any) {
        self.value = value
    }
}

extension AnyComponent: Renderable {
    public func toView(context: BeagleContext, dependencies: Renderable.Dependencies) -> UIView {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 2
        label.text = "Unknown Component of type:\n \(String(describing: value))"
        label.textColor = .red
        label.backgroundColor = .yellow
        return label
    }
}
