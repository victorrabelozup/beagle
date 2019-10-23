//
//  Image.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

public struct Image: NativeWidget {
    
    // MARK: - Public Properties
    
    public let name: String
    private let contentMode: ImageContentMode
    
    // MARK: - Initialization
    
    public init(
        name: String,
        contentMode: ImageContentMode = .fitCenter
    ) {
        self.name = name
        self.contentMode = contentMode
    }
    
}
