//
//  ListViewEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

struct ListViewEntity: WidgetEntity {
    let rows: [WidgetEntityContainer]?
    let remoteDataSource: String?
    let loadingState: WidgetEntityContainer?
    let direction: ListDirectionEntity = .vertical
}

public enum ListDirectionEntity: String, WidgetEntity {
    case vertical
    case horizontal
}
