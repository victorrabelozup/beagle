//
//  SpacerEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct SpacerEntity: WidgetEntity {
    let size: Double
}

extension SpacerEntity: WidgetConvertible {
    func mapToWidget() throws -> Widget {
        return Spacer(size)
    }
}
