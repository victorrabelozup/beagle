//
//  ButtonEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct ButtonEntity: WidgetConvertibleEntity {
    
    let text: String
    var style: String?

    public init(
        text: String,
        style: String? = nil
    ) {
        self.text = text
        self.style = style
    }
    
    func mapToWidget() throws -> Widget {
        return Button(text: text, style: style)
    }
}
