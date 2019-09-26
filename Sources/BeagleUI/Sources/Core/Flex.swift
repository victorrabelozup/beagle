//
//  Flex.swift
//  BeagleUI
//
//  Created by Daniel Tes on 12/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct Flex {
    
    let flexWrap: Wrap
    let justifyContent: JustifyContent
    let alignItems: Alignment
    let alignSelf: Alignment
    let alignContent: Alignment
    let basis: UnitValue
    let grow: Double
    let shrink: Int
    
    init(
        flexWrap: Wrap = .no_wrap,
        justifyContent: JustifyContent = .flex_end,
        alignItems: Alignment = .stretch,
        alignSelf: Alignment = .auto,
        alignContent: Alignment = .flex_start,
        basis: UnitValue = UnitValue(value: 0.0, type: .real),
        grow: Double = 0.0,
        shrink: Int = 0
    ) {
        self.flexWrap = flexWrap
        self.justifyContent = justifyContent
        self.alignItems = alignItems
        self.alignSelf = alignSelf
        self.alignContent = alignContent
        self.basis = basis
        self.grow = grow
        self.shrink = shrink
    }
    
}

extension Flex {
    enum ItemDirection: String, StringRawRepresentable {
        case inherit
        case ltr
        case rtl
    }
}

extension Flex {
    enum Direction: String, StringRawRepresentable {
        case row
        case row_reverse
        case column
        case column_reverse
    }
}

extension Flex {
    enum Wrap: String, StringRawRepresentable {
        case no_wrap
        case wrap
        case wrap_reverse
    }
}

extension Flex {
    enum JustifyContent: String, StringRawRepresentable {
        case flex_start
        case center
        case flex_end
        case space_between
        case space_around
        case space_evenly
    }
}

extension Flex {
    enum Alignment: String, StringRawRepresentable {
        case flex_start
        case center
        case flex_end
        case space_between
        case space_around
        case baseline
        case auto
        case stretch
    }
}
