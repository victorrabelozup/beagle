//
//  ShowNativeDialog.swift
//  BeagleUI
//
//  Created by Lucas Araújo on 21/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

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
