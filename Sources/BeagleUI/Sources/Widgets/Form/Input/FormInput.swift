//
//  FormInput.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 12/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

public struct FormInput: Widget {
    
    public let name: String
    public let required: Bool?
    public let validator: String?
    public let errorMessage: String?
    public let child: Widget

    public init(
        name: String,
        required: Bool? = nil,
        validator: String? = nil,
        errorMessage: String? = nil,
        child: Widget
    ) {
        self.name = name
        self.required = required
        self.validator = validator
        self.errorMessage = errorMessage
        self.child = child
    }
    
}
