//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

public struct NetworkImage: Widget {
    
    public let path: String
    public let contentMode: ImageContentMode?
    
    public var id: String?
    public let appearance: Appearance?
    public let flex: Flex?
    public let accessibility: Accessibility?
    
    // MARK: - Initialization
    
    public init(
        path: String,
        contentMode: ImageContentMode? = nil,
        id: String? = nil,
        appearance: Appearance? = nil,
        flex: Flex? = nil,
        accessibility: Accessibility? = nil
    ) {
        self.path = path
        self.contentMode = contentMode
        self.id = id
        self.appearance = appearance
        self.flex = flex
        self.accessibility = accessibility
    }
    
}

extension NetworkImage: Renderable {
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = (contentMode ?? .fitCenter).toUIKit()
        imageView.applyAppearance(appearance)
        imageView.applyAccessibilityIdentifier(id)
        imageView.flex.setupFlex(flex)
        
        dependencies.network.fetchImage(url: path) { [weak imageView, weak context] result in
            guard let imageView = imageView else { return }
            guard case .success(let data) = result else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                imageView.image = image
                imageView.flex.markDirty()
                context?.applyLayout()
            }
        }
                
        return imageView
    }
}
