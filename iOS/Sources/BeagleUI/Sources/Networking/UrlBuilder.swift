//
//  Copyright © 06/03/20 Zup IT. All rights reserved.
//

import Foundation

public protocol DependencyUrlBuilder {
    var urlBuilder: UrlBuilderProtocol { get }
}

public protocol UrlBuilderProtocol {
    var baseUrl: URL? { get set }

    func build(path: String) -> URL?
}

public class UrlBuilder: UrlBuilderProtocol {

    public var baseUrl: URL?

    public init(baseUrl: URL? = nil) {
        self.baseUrl = baseUrl
    }

    public func build(path: String) -> URL? {
        return URL(string: path, relativeTo: baseUrl)
    }
}
