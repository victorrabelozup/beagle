//
//  BeagleDeepLinkHandler.swift
//  BeagleUI
//
//  Created by Yan Dias on 08/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public protocol BeagleDeepLinkScreenManaging {
    func getNaviteScreen(with path: String, data: [String: String]?) throws -> UIViewController
}
