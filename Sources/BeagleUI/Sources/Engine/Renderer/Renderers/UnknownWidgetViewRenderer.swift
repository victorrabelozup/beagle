//
//  UnknownWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 08/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

final class UnknownWidgetViewRenderer: WidgetViewRenderer {
    
    // MARK: - Properties
    
    private let widget: Widget
    
    // MARK: - Initialization
    
    init(_ widget: Widget) {
        self.widget = widget
    }
    
    // MARK: - Public Functions
    
    func buildView() -> UIView {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 2
        label.text = "Unknown Widget of type \(String(describing: widget))"
        label.textColor = .red
        label.backgroundColor = .yellow
        return label
    }
    
}
