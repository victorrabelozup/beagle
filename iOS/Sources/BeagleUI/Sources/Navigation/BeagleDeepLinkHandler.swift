//
//  BeagleDeepLinkHandler.swift
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

public protocol DeepLinkScreenManaging {
    func getNativeScreen(with path: String, data: [String: String]?) throws -> UIViewController
}

public protocol DependencyDeepLinkScreenManaging {
    var deepLinkHandler: DeepLinkScreenManaging? { get }
}
