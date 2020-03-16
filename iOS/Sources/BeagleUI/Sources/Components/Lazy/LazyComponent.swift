//
//  Copyright © 2019 Zup IT. All rights reserved.
//

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
