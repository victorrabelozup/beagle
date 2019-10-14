//
//  MirrorExtension.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 14/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

extension Mirror {
    func firstChild<T>(of type: T.Type, in label: String? = nil) -> T? {
        return children.lazy.compactMap {
            guard let value = $0.value as? T else { return nil }
            guard let label = label else { return value }
            return $0.label == label ? value : nil
        }.first
    }
}
