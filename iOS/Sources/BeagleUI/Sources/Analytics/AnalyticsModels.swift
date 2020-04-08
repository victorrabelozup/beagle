/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import Foundation

public protocol AnalyticsEvent: Codable { }

public struct AnalyticsClick: AnalyticsEvent {
    
    public let category: String
    public let label: String?
    public let value: String?
    
    public init(
        category: String,
        label: String? = nil,
        value: String? = nil
    ) {
        self.category = category
        self.label = label
        self.value = value
    }
}

public struct AnalyticsScreen: AnalyticsEvent {
    public let screenName: String
    
    public init(screenName: String) {
        self.screenName = screenName
    }
}
