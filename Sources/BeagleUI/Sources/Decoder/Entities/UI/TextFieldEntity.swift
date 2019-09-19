//
//  TextFieldEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines an API representation for `TextField`
struct TextFieldEntity: WidgetEntity {
    let hint: String?
    let value: String?
}
extension TextFieldEntity: WidgetConvertible {
    func mapToWidget() throws -> Widget {
        return TextField(hint: hint, value: value)
    }
}
