//
//  StyledWidgetEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

struct StyledWidgetEntity: WidgetEntity {
    let border: BorderEntity?
    let color: String?
    let child: WidgetEntityContainer?
}

struct BorderEntity: WidgetEntity {
    let color: String?
    let radius: Double?
    let size: Double?
}
