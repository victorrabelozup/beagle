//
//  NetworkImageEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 14/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct NetworkImageEntity: WidgetConvertibleEntity {
    let url: String
    let contentMode: ImageEntityContentMode?
    let appearance: AppearanceEntity?
    
    func mapToWidget() throws -> Widget {
        let contentMode = try self.contentMode?.mapToUIModel(ofType: ImageContentMode.self)
        let appearance = try self.appearance?.mapToUIModel()
        return NetworkImage(url: url, contentMode: contentMode, appearance: appearance)
    }
}
