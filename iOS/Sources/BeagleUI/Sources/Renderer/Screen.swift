/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import UIKit

public struct Screen {
    
    // MARK: - Public Properties
    
    public let identifier: String?
    public let appearance: Appearance?
    public let safeArea: SafeArea?
    public let navigationBar: NavigationBar?
    public let child: ServerDrivenComponent
    public let screenAnalyticsEvent: AnalyticsScreen?
    
    public init(
        identifier: String? = nil,
        appearance: Appearance? = nil,
        safeArea: SafeArea? = nil,
        navigationBar: NavigationBar? = nil,
        screenAnalyticsEvent: AnalyticsScreen? = nil,
        child: ServerDrivenComponent
    ) {
        self.identifier = identifier
        self.appearance = appearance
        self.safeArea = safeArea
        self.navigationBar = navigationBar
        self.child = child
        self.screenAnalyticsEvent = screenAnalyticsEvent
    }
    
    func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        return ScreenComponent(
            identifier: identifier,
            appearance: appearance,
            safeArea: safeArea,
            navigationBar: navigationBar,
            screenAnalyticsEvent: screenAnalyticsEvent,
            child: child
        ).toView(context: context, dependencies: dependencies)
    }
}
