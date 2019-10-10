//
//  ImageWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Yan Dias on 08/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

final class ImageWidgetViewRenderer: WidgetViewRenderer {
    
    // MARK: - Properties
    
    private let widget: Image
    
    // MARK: - Initialization
    
    init(_ widget: Widget) throws {
        guard let image = widget as? Image else {
            throw WidgetViewRenderingError.couldNotCastWidget(widget)
        }
        self.widget = image
    }
    
    // MARK: - Public Functions
    
    //TODO: define how to set image with the path
    func buildView() -> UIView {
        let image = UIImageView(frame: .zero)
        return image
    }
}
