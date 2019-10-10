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
        guard let text = widget as? Text else {
            throw WidgetViewRenderingError.invalidWidgetType
        }
        self.widget = text
    }
    
    func buildView() -> UIView {
        let label = UILabel(frame: .zero)
        label.text = widget.text
        return label
    }
}
