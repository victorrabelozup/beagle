//
//  Validator.swift
//  BeagleUI
//
//  Created by Lucas Araújo on 19/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import Foundation

public protocol Validator {
    func isValid(input: Any) -> Bool
}

public protocol ValidationErrorListener {
    func onValidationError(message: String?)
}
