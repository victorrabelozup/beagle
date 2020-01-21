//
//  Copyright © 04/11/19 Zup IT. All rights reserved.
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
                openDeepLink(path: path, source: source, data: action.data,animated: animated)
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
        
    private func openDeepLink(path: String, source: UIViewController, data: [String: String]?, animated: Bool) {
        guard let deepLinkHandler = Beagle.dependencies.deepLinkHandler else { return }

        do {
            let viewController = try deepLinkHandler.getNaviteScreen(with: path, data: data)
            source.navigationController?.pushViewController(viewController, animated: animated)
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
        guard let viewControllers = source.navigationController?.viewControllers else {
            assertionFailure("Trying to pop when there is nothing to pop"); return
        }

        let last = viewControllers.last {
            isViewController($0, identifiedBy: url)
        }

        guard let target = last else { return }

        source.navigationController?.popToViewController(target, animated: animated)
    }

    private func isViewController(
        _ viewController: UIViewController,
        identifiedBy url: String
    ) -> Bool {
        guard
            let screen = viewController as? BeagleScreenViewController,
            case .remote(let screenUrl) = screen.viewModel.screenType
        else { return false }

        return screenUrl == url
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
