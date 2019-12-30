//
//  ImageWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Yan Dias on 31/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

final class ImageWidgetViewRenderer: ViewRendering<Image> {
    
    override func buildView(context: BeagleContext) -> UIView {
        let image = UIImageView(frame: .zero)
        image.contentMode = (widget.contentMode ?? .fitCenter).toUIKit()
        image.setImageFromAsset(named: widget.name)
        self.flex.enableYoga(true, for: image)
        return image
    }
}

private extension UIImageView {
    func setImageFromAsset(named: String) {
        self.image = UIImage(named: named, in: Beagle.appBundle, compatibleWith: nil)
    }
}
