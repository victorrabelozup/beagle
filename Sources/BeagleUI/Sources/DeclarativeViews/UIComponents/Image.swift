//
//  Image.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

public struct Image: Widget {
    
    // MARK: - Public Properties
    
    public let path: String
    
    // MARK: - Initialization
    
    public init(path: String) {
        self.path = path
    }
    
}
