//
//  NSErrorExtension.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 18/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

extension NSError {
    
    /// A convenience initializer for NSError to set its description.
    ///
    /// - Parameters:
    ///   - domain: The error domain.
    ///   - code: The error code.
    ///   - description: Some description for this error.
    convenience init(domain: String, code: Int, description: String) {
        self.init(domain: domain, code: code, userInfo: [(kCFErrorLocalizedDescriptionKey as CFString) as String: description])
    }
    
}
