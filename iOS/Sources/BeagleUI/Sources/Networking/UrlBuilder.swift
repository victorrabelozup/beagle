/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

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
