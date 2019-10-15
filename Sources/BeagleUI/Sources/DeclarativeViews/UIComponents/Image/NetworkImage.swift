//
//  NetworkImage.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 14/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

public struct NetworkImage: Widget {
    
    public let url: String
    public let contentMode: ImageContentMode
    
    // MARK: - Initialization
    
    public init(
        url: String,
        contentMode: ImageContentMode = .fitCenter
    ) {
        self.url = url
        self.contentMode = contentMode
    }
    
}
