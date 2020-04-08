/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import Foundation

// MARK: - Dependecy Protocol
public protocol DependencyAnalyticsExecutor {
    var analytics: Analytics? { get }
}

// MARK: - Executor Protocol
public protocol Analytics {
    func trackEventOnScreenAppeared(_ event: AnalyticsScreen)
    func trackEventOnScreenDisappeared(_ event: AnalyticsScreen)
    func trackEventOnClick(_ event: AnalyticsClick)
}

// MARK: - Events
public protocol ClickedOnComponent {
    var clickAnalyticsEvent: AnalyticsClick? { get }
}

public protocol ScreenEvent {
    var screenAnalyticsEvent: AnalyticsScreen? { get }
}
