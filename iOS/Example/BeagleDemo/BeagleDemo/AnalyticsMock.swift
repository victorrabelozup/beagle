/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import Foundation
import BeagleUI

class AnalyticsMock: Analytics {
    func trackEventOnScreenAppeared(_ event: AnalyticsScreen) {
        print("Simulating track event on screen appeared with screenName = \(event.screenName)")
    }
    
    func trackEventOnScreenDisappeared(_ event: AnalyticsScreen) {
        print("Simulating track event on screen disappeared with screenName = \(event.screenName)")
    }
    
    func trackEventOnClick(_ event: AnalyticsClick) {
        print("Simulating track event on button touch with:\ncategory = \(event.category)\nlabel = \(event.label ?? "empty")\nvalue = \(event.value ?? "empty")")
    }
}
