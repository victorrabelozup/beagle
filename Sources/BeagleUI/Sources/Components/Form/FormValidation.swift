//
//  Copyright © 2019 Zup IT. All rights reserved.
//

/// Types of transitions between screens
public struct FieldError {
    
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
