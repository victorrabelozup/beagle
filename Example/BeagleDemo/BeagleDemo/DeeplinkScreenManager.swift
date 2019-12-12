//
//  DeeplinkScreenManager.swift
//  BeagleDemo
//
//  Created by Lucas Araújo on 02/12/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit
import BeagleUI

protocol DeeplinkScreen {
    init(path: String, data: [String: String]?)
    var widget: Widget { get }
}

final class DeeplinkScreenManager: BeagleDeepLinkScreenManaging {
    
    public static let shared = DeeplinkScreenManager()
    
    private var screens: [String: DeeplinkScreen.Type] = [:]
    
    public subscript(path: String) -> DeeplinkScreen.Type? {
        get {
            return screens[path]
        }
        set {
            screens[path] = newValue
        }
    }
    
    func getNaviteScreen(with path: String, data: [String : String]?) throws -> UIViewController {
        guard let screenType = self[path] else {
            throw NSError(domain: "DeeplinkScreenManager", code: 1, userInfo: nil)
        }
        let screen = screenType.init(path: path, data: data)
        return BeagleScreenViewController(screen: .declarative(screen.widget))
    }
}
