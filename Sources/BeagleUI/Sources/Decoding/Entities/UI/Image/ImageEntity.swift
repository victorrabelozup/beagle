//
//  ImageEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines an API representation for `Image`
struct ImageEntity: WidgetEntity {
    let name: String
    let contentMode: ImageEntityContentMode
}
extension ImageEntity: WidgetConvertible {
    func mapToWidget() throws -> Widget {
        guard let contentMode = ImageContentMode(rawValue: self.contentMode.rawValue) else {
            let typeName = String(describing: type(of: ImageContentMode.self))
            throw WidgetConvertibleError.entityTypeIsNotConvertible(typeName)
        }
        return Image(name: name, contentMode: contentMode)
    }
}
