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
        let contentMode = try self.contentMode.mapToUIModel(ofType: ImageContentMode.self)
        return NetworkImage(url: url, contentMode: contentMode)
    }
}
