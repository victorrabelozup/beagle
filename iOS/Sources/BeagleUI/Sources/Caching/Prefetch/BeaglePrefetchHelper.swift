/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

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
        dependencies.network.fetchComponent(url: newPath.path, additionalData: nil) {
            switch $0 {
            case .success(let component):
                dependencies.cacheManager.saveComponent(component, forPath: newPath.path)
            case .failure:
                break
            }
        }
    }
}
