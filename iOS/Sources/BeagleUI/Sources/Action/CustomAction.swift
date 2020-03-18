//
//  CustomAction.swift
//  BeagleUI
//
//  Created by Lucas Araújo on 22/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

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
