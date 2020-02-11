//
//  Copyright © 17/12/19 Zup IT. All rights reserved.
//

import Foundation

public protocol DependencyPreFetching {
    var preFetchHelper: BeaglePrefetchHelping { get }
}

public protocol BeaglePrefetchHelping {
    func prefetchComponent(newPath: Navigate.NewPath)
    func dequeueComponent(path: String) -> BeagleScreenViewController
}

public class BeaglePreFetchHelper: BeaglePrefetchHelping {
    
    private var screens = [String: BeagleScreenViewController]()
    
    public func prefetchComponent(newPath: Navigate.NewPath) {
        if newPath.shouldPrefetch {
            guard screens[newPath.path] == nil else { return }

            screens[newPath.path] = BeagleScreenViewController(
                viewModel: .init(screenType: .remote(newPath.path))
            )
        }
    }
    
    public func dequeueComponent(path: String) -> BeagleScreenViewController {
        if let screen = screens[path] {
            return screen
        } else {
            return BeagleScreenViewController(
                viewModel: .init(screenType: .remote(path))
            )
        }
    }
}
