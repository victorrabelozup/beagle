//
//  Text.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public struct Text: UIComponentWidget {
    
    // MARK: - Public Properties
    
    public let text: String
    
    // MARK: - Initialization
    
    public init(_ text: String) {
        self.text = text
    }
    
}
