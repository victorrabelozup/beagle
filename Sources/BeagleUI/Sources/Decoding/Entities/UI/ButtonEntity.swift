//
//  ButtonEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines an API representation for `Button`
struct ButtonEntity: WidgetEntity {
    let text: String
}
extension ButtonEntity: WidgetConvertible {
    func mapToWidget() throws -> Widget {
        return Button(text: text)
    }
}
