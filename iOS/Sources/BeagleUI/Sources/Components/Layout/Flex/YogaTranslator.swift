/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import Foundation
import YogaKit

protocol YogaTranslator {
    func translate(_ direction: Flex.Direction) -> YGDirection
    func translate(_ flexDirection: Flex.FlexDirection) -> YGFlexDirection
    func translate(_ flexWrap: Flex.Wrap) -> YGWrap
    func translate(_ justifyContent: Flex.JustifyContent) -> YGJustify
    func translate(_ alignment: Flex.Alignment) -> YGAlign
    func translate(_ positionType: Flex.PositionType) -> YGPositionType
    func translate(_ unitValue: UnitValue) -> YGValue
    func translate(_ display: Flex.Display) -> YGDisplay
}

final class YogaTranslating: YogaTranslator {
    func translate(_ flexWrap: Flex.Wrap) -> YGWrap {
        switch flexWrap {
        case .noWrap:
            return .noWrap
        case .wrap:
            return .wrap
        case .wrapReverse:
            return .wrapReverse
        }
    }
    
    func translate(_ alignment: Flex.Alignment) -> YGAlign {
        switch alignment {
        case .flexStart:
            return .flexStart
        case .center:
            return .center
        case .flexEnd:
            return .flexEnd
        case .spaceBetween:
            return .spaceBetween
        case .spaceAround:
            return .spaceAround
        case .baseline:
            return .baseline
        case .auto:
            return .auto
        case .stretch:
            return .stretch
        }
    }
    
    func translate(_ justifyContent: Flex.JustifyContent) -> YGJustify {
        switch justifyContent {
        case .flexStart:
            return .flexStart
        case .center:
            return .center
        case .flexEnd:
            return .flexEnd
        case .spaceBetween:
            return .spaceBetween
        case .spaceAround:
            return .spaceAround
        case .spaceEvenly:
            return .spaceEvenly
        }
    }
    
    func translate(_ flexDirection: Flex.FlexDirection) -> YGFlexDirection {
        switch flexDirection {
        case .row:
            return .row
        case .rowReverse:
            return .rowReverse
        case .column:
            return .column
        case .columnReverse:
            return .columnReverse
        }
    }
    
    func translate(_ direction: Flex.Direction) -> YGDirection {
        switch direction {
        case .inherit:
            return .inherit
        case .ltr:
            return .LTR
        case .rtl:
            return .RTL
        }
    }
    
    func translate(_ display: Flex.Display) -> YGDisplay {
        switch display {
        case .flex:
            return .flex
        case .none:
            return .none
        }
    }
    
    func translate(_ unitValue: UnitValue) -> YGValue {
        let value = Float(unitValue.value)
        switch unitValue.type {
        case .auto:
            return YGValue(value: value, unit: .auto)
        case .percent:
            return YGValue(value: value, unit: .percent)
        case .real:
            return YGValue(value: value, unit: .point)
        }
    }
    
    func translate(_ positionType: Flex.PositionType) -> YGPositionType {
        switch positionType {
        case .absolute:
            return .absolute
        case .relative:
            return .relative
        }
    }
    
}
