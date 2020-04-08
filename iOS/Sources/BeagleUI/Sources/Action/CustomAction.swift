/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */


import Foundation

/// A custom action to be implemented by the application
public struct CustomAction: Action {
    
    public let name: String
    public let data: [String: String]
    
    public init(
        name: String,
        data: [String: String]
    ) {
        self.name = name
        self.data = data
    }
}
