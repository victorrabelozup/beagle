//
//  VerticalEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines an API representation for `Vertical`
struct VerticalEntity: WidgetEntity, Codable {
    let children: [WidgetEntityContainer]
}
