//
//  NetworkImage.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 14/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

struct NetworkImage: Widget {
    
    let url: String
    let contentMode: ImageContentMode
    
    // MARK: - Initialization
       
       public init(
           url: String,
           contentMode: ImageContentMode = .scaleAspectFit
       ) {
           self.url = url
           self.contentMode = contentMode
       }
}
