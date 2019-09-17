//
//  Flex.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct Flex {
    let flexWrap: FlexWrap = .no_wrap
    let justifyContent: JustifyContent = .flex_end
    let alignItems: Alignment = .stretch
    let alignSelf: Alignment = .auto
    let alignContent: Alignment = .flex_start
    let basis: String = "0"
    let grow: Double = 0.0
    let shrink: Int = 0
}

enum ItemDirection {
    case inherit
    case ltr
    case rtl
}

enum FlexDirection {
    case row
    case row_reverse
    case column
    case column_reverse
}

enum FlexWrap {
    case no_wrap
    case wrap
    case wrap_reverse
}

enum JustifyContent {
    case flex_start
    case center
    case flex_end
    case space_between
    case space_around
    case space_evenly
}

enum Alignment {
    case flex_start
    case center
    case flex_end
    case space_between
    case space_around
    case baseline
    case auto
    case stretch
}
