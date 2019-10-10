//
//  TextFieldWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Gabriela Coelho on 09/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

final class TextFieldWidgetViewRenderer: WidgetViewRenderer {
    private let widget: TextField

    init(_ widget: Widget) throws {
        self.widget = try .byCasting(widget: widget, to: TextField.self)

    }
    
    func buildView() -> UIView {
        let textField = UITextField(frame: .zero)
        textField.text = widget.value
        textField.placeholder = widget.hint
        return textField
    }
}
