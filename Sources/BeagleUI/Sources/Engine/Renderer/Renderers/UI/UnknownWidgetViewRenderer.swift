//
//  UnknownWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 08/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

final class UnknownWidgetViewRenderer: WidgetViewRendererProtocol {
    
    let widget: AnyWidget
    
    init(_ widget: Widget) {
        self.widget = AnyWidget(value: widget as Any)
    }
    
    // MARK: - Public Functions
    
    func buildView() -> UIView {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 2
        label.text = "Unknown Widget of type:\n \(String(describing: widget))"
        label.textColor = .red
        label.backgroundColor = .yellow
        return label
    }
    
}
