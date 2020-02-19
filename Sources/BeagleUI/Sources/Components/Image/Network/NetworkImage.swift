//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

public struct NetworkImage: AppearanceComponent {
    
    public let path: String
    public let contentMode: ImageContentMode?
    public let appearance: Appearance?
    
    // MARK: - Initialization
    
    public init(
        path: String,
        contentMode: ImageContentMode? = nil,
        appearance: Appearance? = nil
    ) {
        self.path = path
        self.contentMode = contentMode
        self.appearance = appearance
    }
    
}

extension NetworkImage: Renderable {
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let imageView = NetworkUIImageView(network: dependencies.network, url: path)
        imageView.contentMode = (contentMode ?? .fitCenter).toUIKit()
        imageView.applyAppearance(appearance)
        let flex = Flex(size: .init(width: 100%, height: 100%))
        imageView.flex.setupFlex(flex)
        return imageView
    }
}
