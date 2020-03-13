//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

public protocol ServerDrivenComponent: Renderable, Decodable {}

public protocol ComposeComponent: ServerDrivenComponent {
    func build() -> ServerDrivenComponent
}

extension ComposeComponent {
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        return build().toView(context: context, dependencies: dependencies)
    }
}

public protocol Renderable {
    func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView
}

public protocol RenderableDependencies: DependencyTheme,
    DependencyValidatorProvider,
    DependencyPreFetching,
    DependencyAppBundle,
    DependencyNetwork,
    DependencyCacheManager {
}

extension ServerDrivenComponent {
    public func toScreen() -> Screen {
        let screen = self as? ScreenComponent
        let safeArea = screen?.safeArea
            ?? SafeArea(top: true, leading: true, bottom: true, trailing: true)

        return Screen(
            appearance: screen?.appearance,
            safeArea: safeArea,
            navigationBar: screen?.navigationBar,
            child: screen?.child ?? self
        )
    }
}