/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */


import UIKit

final class ActionGestureRecognizer: UITapGestureRecognizer {
    
    let action: Action
    
    init(action: Action, target: Any?, selector: Selector?) {
        self.action = action
        super.init(target: target, action: selector)
    }
}
