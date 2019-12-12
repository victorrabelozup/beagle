//
//  NetworkImageWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Gabriela Coelho on 01/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit
import YogaKit

final class NetworkImageWidgetViewRenderer: WidgetViewRenderer<NetworkImage> {
    
    private var imageDataProvider: ImageDataProvider = ImageDataProviding()
    
    override func buildView(context: BeagleContext) -> UIView {
        let imageView = NetworkUIImageView(imageDataProvider: imageDataProvider, url: widget.url)
        imageView.contentMode = widget.contentMode.toUIKit()
        let flex = Flex(size: .init(width: 100%, height: 100%))
        self.flex.setupFlex(flex, for: imageView)
        self.flex.enableYoga(true, for: imageView)
        return imageView
    }
}
