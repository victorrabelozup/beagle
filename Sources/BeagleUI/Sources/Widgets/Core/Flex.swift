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
        case inherit = "INHERIT"
        case ltr = "LTR"
        case rtl = "RTL"
    }
}

extension Flex {
    enum Direction: String, StringRawRepresentable {
        case row = "ROW"
        case row_reverse = "ROW_REVERSE"
        case column = "COLUMN"
        case column_reverse = "COLUMN_REVERSE"
    }
}

extension Flex {
    enum Wrap: String, StringRawRepresentable {
        case no_wrap = "NO_WRAP"
        case wrap = "WRAP"
        case wrap_reverse = "WRAP_REVERSE"
    }
}

extension Flex {
    enum JustifyContent: String, StringRawRepresentable {
        case flex_start = "FLEX_START"
        case center = "CENTER"
        case flex_end = "FLEX_END"
        case space_between = "SPACE_BETWEEN"
        case space_around = "SPACE_AROUND"
        case space_evenly = "SPACE_EVENLY"
    }
}

extension Flex {
    enum Alignment: String, StringRawRepresentable {
        case flex_start = "FLEX_START"
        case center = "CENTER"
        case flex_end = "FLEX_END"
        case space_between = "SPACE_BETWEEN"
        case space_around = "SPACE_AROUND"
        case baseline = "BASELINE"
        case auto = "AUTO"
        case stretch = "STRETCH"
    }
}
