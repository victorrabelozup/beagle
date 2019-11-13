//
//  TextEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines an API representation for `Text`
struct TextEntity: WidgetEntity {
    let text: String
    let style: String?
    
    init(
        text: String,
        style: String? = nil
    ) {
        self.text = text
        self.style = style
    }
}

extension TextEntity: WidgetConvertible {
    func mapToWidget() throws -> Widget {
        return Text(text, style: style)
    }
}
