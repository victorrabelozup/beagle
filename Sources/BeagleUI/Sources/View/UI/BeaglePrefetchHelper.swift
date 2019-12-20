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
        screens[path] = BeagleScreenViewController(screenType: .remote(path))
    }
    
    public func dequeueWidget(path: String) -> BeagleScreenViewController {
        guard let screen = screens[path] else {
            return BeagleScreenViewController(screenType: .remote(path))
        }
        return screen
    }
}
