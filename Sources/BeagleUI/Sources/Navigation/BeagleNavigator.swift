//
//  BeagleNavigator.swift
//  BeagleUI
//
//  Created by Lucas Araújo on 04/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

public protocol BeagleNavigation {
    func navigate(action: Navigate, context: BeagleContext, animated: Bool)
}

public protocol DependencyNavigation {
    var navigation: BeagleNavigation { get }
}

class BeagleNavigator: BeagleNavigation {
    
    typealias Dependencies = DependencyPreFetching
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Navigate
    
    func navigate(action: Navigate, context: BeagleContext, animated: Bool = false) {
        let source = context.screenController
        switch action.type {
        case .openDeepLink:
            if let path = action.path {
                openDeepLink(path: path, source: source, animated: animated)
            }
        case .swapView:
            if let url = action.path {
                swapView(url: url, context: context, animated: animated)
            }
        case .addView:
            if let url = action.path {
                addView(url: url, context: context, animated: animated)
            }
        case .finishView:
            finishView(source: source, animated: animated)
        case .popView:
            popView(source: source, animated: animated)
        case .popToView:
            if let url = action.path {
                popToView(url: url, source: source, animated: animated)
            }
        case .presentView:
            if let url = action.path {
                presentView(url: url, context: context, animated: animated)
            }
        }
    }
    
    // MARK: - Navigation Methods
        
    private func openDeepLink(path: String, source: UIViewController, animated: Bool) {
        do {
            if let deepLinkHandler = Beagle.deepLinkHandler {
                let viewController = try deepLinkHandler.getNaviteScreen(with: path, data: nil)
                source.navigationController?.pushViewController(viewController, animated: animated)
            }
        } catch {
            return
        }
    }
    
    private func finishView(source: UIViewController, animated: Bool) {
        source.navigationController?.dismiss(animated: animated)
    }
    
    private func popView(source: UIViewController, animated: Bool) {
        source.navigationController?.popViewController(animated: animated)
    }
    
    private func popToView(url: String, source: UIViewController, animated: Bool) {
        let viewControllers = source.navigationController?.viewControllers
        
        let targetViewController = viewControllers?.last {
            guard let screenType = ($0 as? BeagleScreenViewController)?.screenType else {
                return false
            }
            if case let .remote(screenURL) = screenType {
                return screenURL == url
            }
            return false
        }
        if let targetViewController = targetViewController {
            source.navigationController?.popToViewController(targetViewController, animated: animated)
        }
    }
    
    private func swapView(url: String, context: BeagleContext, animated: Bool) {
        let viewController = dependencies.preFetchHelper.dequeueWidget(path: url)
        context.screenController.navigationController?.setViewControllers([viewController], animated: animated)
    }

    private func addView(url: String, context: BeagleContext, animated: Bool) {
        let viewController = dependencies.preFetchHelper.dequeueWidget(path: url)
        context.screenController.navigationController?.pushViewController(viewController, animated: animated)
    }

    private func presentView(url: String, context: BeagleContext, animated: Bool) {
        let viewController = dependencies.preFetchHelper.dequeueWidget(path: url)
        let navigationToPresent = UINavigationController(rootViewController: viewController)
        context.screenController.navigationController?.present(navigationToPresent, animated: animated)
    }
}
