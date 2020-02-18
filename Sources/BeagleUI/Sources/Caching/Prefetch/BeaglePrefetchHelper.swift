//
//  Copyright © 17/12/19 Zup IT. All rights reserved.
//

import Foundation

public typealias Dependencies =
    DependencyNetwork
    & DependencyCacheManager

public protocol DependencyPreFetching {
    var preFetchHelper: BeaglePrefetchHelping { get }
}

public protocol BeaglePrefetchHelping {
    func prefetchComponent(newPath: Navigate.NewPath, dependencies: Dependencies)
}

public class BeaglePreFetchHelper: BeaglePrefetchHelping {
    
    public func prefetchComponent(newPath: Navigate.NewPath, dependencies: Dependencies) {
        guard newPath.shouldPrefetch, dependencies.cacheManager.dequeueComponent(path: newPath.path) == nil else { return }
        dependencies.network.fetchComponent(url: newPath.path) {
            switch $0 {
            case .success(let component):
                dependencies.cacheManager.saveComponent(component, forPath: newPath.path)
            case .failure:
                break
            }
        }
    }
}
