//
//  FormSubmit.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 12/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

public struct FormSubmit: Widget {
    
    // MARK: - Public Properties
    
    public let child: Widget
    
    // MARK: - Initialization
    
    public init(
        child: Widget
    ) {
        self.child = child
    }
    
}
