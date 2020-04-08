/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

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
    DependencyCacheManager,
    DependencyLogger {
}

extension ServerDrivenComponent {
    public func toScreen() -> Screen {
        let screen = self as? ScreenComponent
        let safeArea = screen?.safeArea
            ?? SafeArea(top: true, leading: true, bottom: true, trailing: true)

        return Screen(
            identifier: screen?.identifier,
            appearance: screen?.appearance,
            safeArea: safeArea,
            navigationBar: screen?.navigationBar,
            screenAnalyticsEvent: screen?.screenAnalyticsEvent,
            child: screen?.child ?? self
        )
    }
}
