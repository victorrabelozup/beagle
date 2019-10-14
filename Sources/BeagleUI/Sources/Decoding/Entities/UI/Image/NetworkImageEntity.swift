//
//  NetworkImageEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 14/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines an API representation for `NetworkImage`
struct NetworkImageEntity: WidgetEntity {
    let url: String
    let contentMode: ImageEntityContentMode
}
extension NetworkImageEntity: WidgetConvertible {
    func mapToWidget() throws -> Widget {
        guard let contentMode = ImageContentMode(rawValue: self.contentMode.rawValue) else {
            let typeName = String(describing: type(of: ImageContentMode.self))
            throw WidgetConvertibleError.entityTypeIsNotConvertible(typeName)
        }
        return NetworkImage(url: url, contentMode: contentMode)
    }
}
