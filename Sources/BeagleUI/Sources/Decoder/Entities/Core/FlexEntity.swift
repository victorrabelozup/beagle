//
//  Flex.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

struct FlexEntity: WidgetEntity {
    let flexWrap: FlexWrapEntity = .no_wrap
    let justifyContent: JustifyContentEntity = .flex_end
    let alignItems: AlignmentEntity = .stretch
    let alignSelf: AlignmentEntity = .auto
    let alignContent: AlignmentEntity = .flex_start
    let basis: String = "0"
    let grow: Double = 0.0
    let shrink: Int = 0
}

enum ItemDirectionEntity: String, WidgetEntity {
    case inherit
    case ltr
    case rtl
}

enum FlexDirectionEntity: String, WidgetEntity {
    case row
    case row_reverse
    case column
    case column_reverse
}

enum FlexWrapEntity: String, WidgetEntity {
    case no_wrap
    case wrap
    case wrap_reverse
}

enum JustifyContentEntity: String, WidgetEntity {
    case flex_start
    case center
    case flex_end
    case space_between
    case space_around
    case space_evenly
}

enum AlignmentEntity: String, WidgetEntity {
    case flex_start
    case center
    case flex_end
    case space_between
    case space_around
    case baseline
    case auto
    case stretch
}
