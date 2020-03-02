//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

public struct Image: Widget {
    
    // MARK: - Public Properties
    
    public let name: String
    public let contentMode: ImageContentMode?
    
    public var id: String?
    public let appearance: Appearance?
    public let flex: Flex?
    public let accessibility: Accessibility?
    
    // MARK: - Initialization
    
    public init(
        name: String,
        contentMode: ImageContentMode? = nil,
        id: String? = nil,
        appearance: Appearance? = nil,
        flex: Flex? = nil,
        accessibility: Accessibility? = nil
    ) {
        self.name = name
        self.contentMode = contentMode
        self.id = id
        self.appearance = appearance
        self.flex = flex
        self.accessibility = accessibility
    }
    
}

extension Image: Renderable {
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let image = UIImageView(frame: .zero)
        image.clipsToBounds = true
        image.contentMode = (contentMode ?? .fitCenter).toUIKit()
        image.setImageFromAsset(named: name, bundle: dependencies.appBundle)
        
        image.applyAccessibilityIdentifier(id)
        image.applyAppearance(appearance)
        image.flex.setupFlex(flex)
        dependencies.accessibility.applyAccessibilityAttributes(accessibility, to: image)
        
        return image
    }
}

private extension UIImageView {
    func setImageFromAsset(named: String, bundle: Bundle) {
        self.image = UIImage(named: named, in: bundle, compatibleWith: nil)
    }
}
