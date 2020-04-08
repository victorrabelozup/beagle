/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import UIKit

 public struct LazyComponent: ServerDrivenComponent {
    
    // MARK: - Public Properties
    
    public let path: String
    public let initialState: ServerDrivenComponent
        
    // MARK: - Initialization
    
    public init(
        path: String,
        initialState: ServerDrivenComponent
    ) {
        self.path = path
        self.initialState = initialState
    }
}

extension LazyComponent: Renderable {
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let view = initialState.toView(context: context, dependencies: dependencies)
        context.lazyLoad(url: path, initialState: view)
        return view
    }
}

extension LazyComponent: Decodable {
    enum CodingKeys: String, CodingKey {
        case path
        case initialState
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.path = try container.decode(String.self, forKey: .path)
        self.initialState = try container.decode(forKey: .initialState)
    }
}
