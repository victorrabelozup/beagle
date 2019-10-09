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
        guard let textField = widget as? TextField else {
            throw WidgetViewRenderingError.invalidWidgetType
        }
        self.widget = textField
    }
    
    func buildView() -> UIView {  // TODO: VERIFY TEXT FIELD ON ANDROID, HAS "HINT" ?? WTF
        let textField = UITextField(frame: .zero)
        textField.text = widget.value
        return textField
    }
}

