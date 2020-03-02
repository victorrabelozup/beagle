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
    
    typealias Dependencies = DependencyDeepLinkScreenManaging
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Navigate
    
    func navigate(action: Navigate, context: BeagleContext, animated: Bool = false) {
        let source = context.screenController
        switch action {
        case .openDeepLink(let deepLink):
            if let component = deepLink.component {
                openDeepLink(component: component, source: source, data: deepLink.data, animated: animated)
            } else {
                openDeepLink(path: deepLink.path, source: source, data: deepLink.data, animated: animated)
            }

        case .swapScreen(let screen):
            swapTo(viewController(screen: screen), context: context, animated: animated)
            
        case .swapView(let newPath):
            swapTo(viewController(newPath: newPath), context: context, animated: animated)

        case .addScreen(let screen):
            add(viewController(screen: screen), context: context, animated: animated)
            
        case .addView(let newPath):
            add(viewController(newPath: newPath), context: context, animated: animated)
            
        case .presentScreen(let screen):
            present(viewController(screen: screen), context: context, animated: animated)
            
        case .presentView(let newPath):
            present(viewController(newPath: newPath), context: context, animated: animated)

        case .finishView:
            finishView(source: source, animated: animated)

        case .popView:
            popView(source: source, animated: animated)

        case .popToView(let path):
            popToView(url: path, source: source, animated: animated)
        }
    }
    
    // MARK: - Navigation Methods
        
    private func openDeepLink(path: String, source: UIViewController, data: [String: String]?, animated: Bool) {
        guard let deepLinkHandler = dependencies.deepLinkHandler else { return }

        do {
            let viewController = try deepLinkHandler.getNativeScreen(with: path, data: data)
            source.navigationController?.pushViewController(viewController, animated: animated)
        } catch {
            return
        }
    }

    private func openDeepLink(component: ServerDrivenComponent, source: UIViewController, data: [String: String]?, animated: Bool) {
        let viewController = BeagleScreenViewController(viewModel: .init(screenType: .declarative(Screen(content: component))))
        let navigationToPresent = UINavigationController(rootViewController: viewController)
        source.navigationController?.present(navigationToPresent, animated: animated, completion: nil)
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
            case .remote(let screenUrl, _) = screen.viewModel.screenType
        else { return false }
        return screenUrl == url
    }
    
    private func swapTo(_ viewController: UIViewController, context: BeagleContext, animated: Bool) {
        context.screenController.navigationController?.setViewControllers([viewController], animated: animated)
    }

    private func add(_ viewController: UIViewController, context: BeagleContext, animated: Bool) {
        context.screenController.navigationController?.pushViewController(viewController, animated: animated)
    }

    private func present(_ viewController: UIViewController, context: BeagleContext, animated: Bool) {
        context.screenController.navigationController?.present(viewController, animated: animated)
    }
    
    private func viewController(screen: Screen) -> UIViewController {
        return BeagleScreenViewController(viewModel: .init(
            screenType: .declarative(screen)
        ))
    }
    
    private func viewController(newPath: Navigate.NewPath) -> UIViewController {
        return BeagleScreenViewController(viewModel: .init(
            screenType: .remote(newPath.path, fallback: newPath.fallback)
        ))
    }
}
