//
//  ImageEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct ImageEntity: WidgetConvertibleEntity {
    let name: String
    let contentMode: ImageEntityContentMode
    
    func mapToWidget() throws -> Widget {
        let contentMode = try self.contentMode.mapToUIModel(ofType: ImageContentMode.self)
        return Image(name: name, contentMode: contentMode)
    }
}
