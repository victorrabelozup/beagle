/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

/// Markup to define an action to be triggred in response to some event
public protocol Action: Decodable {}

/// Defines a representation of an unknwon Action
public struct UnknownAction: Action {
    public let type: String
    
    public init(type: String) {
        self.type = type
    }
}
