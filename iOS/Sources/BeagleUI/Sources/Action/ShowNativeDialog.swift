/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import Foundation

/// Action to represent a native alert
public struct ShowNativeDialog: Action {
    
    public let title: String
    public let message: String
    public let buttonText: String
    
    public init(
        title: String,
        message: String,
        buttonText: String
    ) {
        self.title = title
        self.message = message
        self.buttonText = buttonText
    }
}
