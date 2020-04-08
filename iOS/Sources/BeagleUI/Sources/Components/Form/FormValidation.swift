/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

/// Types of transitions between screens
public struct FieldError: Decodable {
    
    public let inputName: String
    public let message: String
    
    public init(
        inputName: String,
        message: String
    ) {
        self.inputName = inputName
        self.message = message
    }
}

/// Action to represent a form validation error
public struct FormValidation: Action {
    
    public let errors: [FieldError]
    
    public init(
        errors: [FieldError]
    ) {
        self.errors = errors
    }
}
