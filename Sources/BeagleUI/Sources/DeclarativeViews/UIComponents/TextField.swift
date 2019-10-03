//
//  TextField.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

public struct TextField: Widget {
    
    public let hint: String?
    public let value: String?
    
    public init(
        hint: String? = nil,
        value: String? = nil
    ) {
        self.hint = hint
        self.value = value
    }
    
}
