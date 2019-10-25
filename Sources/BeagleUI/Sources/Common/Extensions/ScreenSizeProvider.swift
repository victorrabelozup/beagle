//
//  ScreenSizeProvider.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 24/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

protocol ScreenSizeProvider {
    var size: CGSize { get }
}
extension UIScreen: ScreenSizeProvider {
    var size: CGSize {
        return bounds.size
    }
}
