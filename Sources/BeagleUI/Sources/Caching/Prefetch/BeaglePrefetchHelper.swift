//
//  Copyright © 17/12/19 Zup IT. All rights reserved.
//

import Foundation

public protocol DependencyPreFetching {
    var preFetchHelper: BeaglePrefetchHelping { get }
}

public protocol BeaglePrefetchHelping {
    func prefetchComponent(newPath: Navigate.NewPath, dependencies: DependencyNetwork)
    func dequeueComponent(path: String) -> ServerDrivenComponent?
}

public class BeaglePreFetchHelper: BeaglePrefetchHelping {
    
    private var components = [String: ServerDrivenComponent]()
    
    public func prefetchComponent(newPath: Navigate.NewPath, dependencies: DependencyNetwork) {
        guard newPath.shouldPrefetch, components[newPath.path] == nil else { return }
        dependencies.network.fetchComponent(url: newPath.path) { [weak self] in
            switch $0 {
            case .success(let component):
                self?.components[newPath.path] = component
            case .failure:
                break
            }
        }
    }
    
    public func dequeueComponent(path: String) -> ServerDrivenComponent? {
        return components[path]
    }
}
