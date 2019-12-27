//
//  Copyright © 17/12/19 Zup IT. All rights reserved.
//

import Foundation

public protocol DependencyPreFetching {
    var preFetchHelper: BeaglePrefetchHelping { get }
}

public protocol BeaglePrefetchHelping {
    func prefetchWidget(path: String)
    func dequeueWidget(path: String) -> BeagleScreenViewController
}

public class BeaglePreFetchHelper: BeaglePrefetchHelping {
    
    private var screens = [String: BeagleScreenViewController]()
    
    public func prefetchWidget(path: String) {
        guard screens[path] == nil else { return }

        screens[path] = BeagleScreenViewController(
            viewModel: .init(screenType: .remote(path))
        )
    }
    
    public func dequeueWidget(path: String) -> BeagleScreenViewController {
        if let screen = screens[path] {
            return screen
        } else {
            return BeagleScreenViewController(
                viewModel: .init(screenType:.remote(path))
            )
        }
    }
}
