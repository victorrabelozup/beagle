//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

public struct Image: Widget, HasAppearance {
    
    // MARK: - Public Properties
    
    public let name: String
    public let contentMode: ImageContentMode?
    public let appearance: Appearance?
    
    // MARK: - Initialization
    
    public init(
        name: String,
        contentMode: ImageContentMode? = nil,
        appearance: Appearance? = nil
    ) {
        self.name = name
        self.contentMode = contentMode
        self.appearance = appearance
    }
    
}

extension Image: Renderable {
    public func toView(context: BeagleContext, dependencies: Renderable.Dependencies) -> UIView {
        let image = UIImageView(frame: .zero)
        image.contentMode = (contentMode ?? .fitCenter).toUIKit()
        image.setImageFromAsset(named: name, bundle: dependencies.appBundle)
        image.applyAppearance(appearance)
        dependencies.flex.enableYoga(true, for: image)
        return image
    }
}

private extension UIImageView {
    func setImageFromAsset(named: String, bundle: Bundle) {
        self.image = UIImage(named: named, in: bundle, compatibleWith: nil)
    }
}
