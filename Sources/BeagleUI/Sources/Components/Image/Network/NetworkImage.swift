//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

public struct NetworkImage: AppearanceComponent {
    
    public let url: String
    public let contentMode: ImageContentMode?
    public let appearance: Appearance?
    
    // MARK: - Initialization
    
    public init(
        url: String,
        contentMode: ImageContentMode? = nil,
        appearance: Appearance? = nil
    ) {
        self.url = url
        self.contentMode = contentMode
        self.appearance = appearance
    }
    
}

extension NetworkImage: Renderable {
    public func toView(context: BeagleContext, dependencies: Renderable.Dependencies) -> UIView {
        let imageView = NetworkUIImageView(network: dependencies.network, url: url)
        imageView.contentMode = (contentMode ?? .fitCenter).toUIKit()
        imageView.applyAppearance(appearance)
        let flex = Flex(size: .init(width: 100%, height: 100%))
        dependencies.flex.setupFlex(flex, for: imageView)
        return imageView
    }
}
