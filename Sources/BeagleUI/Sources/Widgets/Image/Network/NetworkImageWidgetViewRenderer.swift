//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit
import YogaKit

final class NetworkImageWidgetViewRenderer: ViewRendering<NetworkImage> {
    
    private var imageDataProvider: ImageDataProvider = ImageDataProviding()
    
    override func buildView(context: BeagleContext) -> UIView {
        let imageView = NetworkUIImageView(imageDataProvider: imageDataProvider, url: widget.url)
        imageView.contentMode = (widget.contentMode ?? .fitCenter).toUIKit()
        imageView.applyAppearance(widget.appearance)
        let flex = Flex(size: .init(width: 100%, height: 100%))
        self.flex.setupFlex(flex, for: imageView)
        return imageView
    }
}
