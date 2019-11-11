//
//  NSObjectExtension.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 07/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

extension NSObject {
    
    /// String describing the class name.
    static var className: String {
        return String(describing: self)
    }
    
}
