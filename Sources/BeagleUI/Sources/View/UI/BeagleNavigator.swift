//
//  BeagleNavigator.swift
//  BeagleUI
//
//  Created by Lucas Araújo on 04/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

struct BeagleNavigator {
    
    static func navigate(action: Navigate, source: UIViewController, animated: Bool = false) {
        switch action.type {
        case .openDeepLink:
            openDeepLink()
        case .swapView:
            if let url = urlFor(action: action) {
                swapView(url: url, source: source, animated: animated)
            }
        case .addView:
            if let url = urlFor(action: action) {
                addView(url: url, source: source, animated: animated)
            }
        case .finishView:
            finishView(source: source, animated: animated)
        case .popView:
            popView(source: source, animated: animated)
        case .popToView:
            if let url = urlFor(action: action) {
                popToView(url: url, source: source, animated: animated)
            }
        case .presentView:
            if let url = urlFor(action: action) {
                presentView(url: url, source: source, animated: animated)
            }
        }
    }
    
    private static func urlFor(action: Navigate) -> URL? {
        guard let path = action.path else {
            return nil
        }
        return URL(string: path)
    }
    
    private static func openDeepLink() {
    }
    
    private static func swapView(url: URL, source: UIViewController, animated: Bool) {
        let viewController = BeagleScreenViewController(screenType: .remote(url))
        source.navigationController?.setViewControllers([viewController], animated: animated)
    }
    
    private static func addView(url: URL, source: UIViewController, animated: Bool) {
        let viewController = BeagleScreenViewController(screenType: .remote(url))
        source.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    private static func finishView(source: UIViewController, animated: Bool) {
        source.navigationController?.dismiss(animated: animated)
    }
    
    private static func popView(source: UIViewController, animated: Bool) {
        source.navigationController?.popViewController(animated: animated)
    }
    
    private static func popToView(url: URL, source: UIViewController, animated: Bool) {
        let viewControllers = source.navigationController?.viewControllers ?? []
        let targetIndex = viewControllers.lastIndex {
            guard let screenType = ($0 as? BeagleScreenViewController)?.screenType else {
                return false
            }
            if case let .remote(screenURL) = screenType {
                return screenURL.absoluteURL == url.absoluteURL
            }
            return false
        }
        if let targetIndex = targetIndex {
            let newStack = Array(viewControllers[viewControllers.startIndex ... targetIndex])
            source.navigationController?.setViewControllers(newStack, animated: animated)
        }
    }
    
    private static func presentView(url: URL, source: UIViewController, animated: Bool) {
        let viewController = BeagleScreenViewController(screenType: .remote(url))
        let navigation = UINavigationController(rootViewController: viewController)
        source.navigationController?.present(navigation, animated: animated)
    }
    
}
