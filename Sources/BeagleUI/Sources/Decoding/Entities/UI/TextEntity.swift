//
//  TextEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct TextEntity: WidgetConvertibleEntity {
    
    let text: String
    var style: String?

    func mapToWidget() throws -> Widget {
        return Text(text, style: style)
    }
}
