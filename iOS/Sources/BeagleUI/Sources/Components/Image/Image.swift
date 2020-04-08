/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

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
        
        image.beagle.setup(self)
        
        return image
    }
}

private extension UIImageView {
    func setImageFromAsset(named: String, bundle: Bundle) {
        self.image = UIImage(named: named, in: bundle, compatibleWith: nil)
    }
}
