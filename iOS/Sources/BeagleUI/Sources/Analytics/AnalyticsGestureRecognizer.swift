/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import UIKit

final class EventsGestureRecognizer: UITapGestureRecognizer {
    let events: [Event]
    
    init(events: [Event], target: Any?, selector: Selector?) {
        self.events = events
        super.init(target: target, action: selector)
    }
}

final class AnalyticsGestureRecognizer: UITapGestureRecognizer {
    
    let click: AnalyticsClick
    
    init(event: AnalyticsClick, target: Any?, selector: Selector?) {
        self.click = event
        super.init(target: target, action: selector)
    }
}
