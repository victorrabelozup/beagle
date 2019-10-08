//
//  ButtonWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Yan Dias on 08/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

final class ButtonWidgetViewRenderer: WidgetViewRenderer {
    // MARK: - Properties
    
    private let widget: Button
    
    // MARK: - Initialization
    
    init(_ widget: Widget) throws {
        guard let button = widget as? Button else {
            throw WidgetViewRenderingError.invalidWidgetType
        }
        self.widget = button
    }
    
    // MARK: - Public Functions
    
    func buildView() -> UIView {
        let button = UIButton(frame: .zero)
        button.setTitle(widget.text, for: .normal)
        return button
    }
}
