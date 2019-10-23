//
//  FlexTranslator.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 04/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation
import YogaKit

protocol YogaTranslator {
    func translate(_ wrap: Flex.Wrap) -> YGWrap
    func translate(_ alignment: Flex.Alignment) -> YGAlign
    func translate(_ justifyContent: Flex.JustifyContent) -> YGJustify
    func translate(_ direction: Flex.Direction) -> YGDirection
    func translate(_ flexDirection: Flex.FlexDirection) -> YGFlexDirection
    func translate(_ display: Flex.Display) -> YGDisplay
    func translate(_ unitValue: UnitValue) -> YGValue
}

final class YogaTranslating: YogaTranslator {
    
    func translate(_ wrap: Flex.Wrap) -> YGWrap {
        switch wrap {
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
        case .percent:
            return YGValue(value: value, unit: .percent)
        case .real:
            return YGValue(value: value, unit: .undefined)
        }
    }
    
}
