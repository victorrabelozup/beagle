//
//  ImageWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Yan Dias on 31/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

final class ImageWidgetViewRenderer: WidgetViewRenderer<Image> {
    
    override func buildView() -> UIView {
        let image = UIImageView(frame: .zero)
        image.contentMode = widget.contentMode.toUIKit()
        image.setImageFromAsset(named: widget.name)
        flexViewConfigurator.enableYoga(true, for: image)
        return image
    }
}

private extension UIImageView {
    func setImageFromAsset(named: String) {
        self.image = UIImage(named: named, in: BeagleEnvironment.shared.appBundle, compatibleWith: nil)
    }
}
