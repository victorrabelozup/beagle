//
//  TextWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Gabriela Coelho on 08/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

final class TextWidgetViewRenderer: WidgetViewRenderer {
    private let widget: Text
    
    init(_ widget: Widget) throws {
        self.widget = try .newByCasting(widget: widget, to: Text.self)
    }
    
    func buildView() -> UIView {
        let label = UILabel(frame: .zero)
        label.text = widget.text
        return label
    }
}
