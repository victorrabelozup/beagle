//
//  Flex+Fixture.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 14/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

// MARK: - Flex All Fixture

extension Flex {
    static func fixtureWithAll(
        direction: Direction = .ltr,
        flexDirection: FlexDirection = .column,
        flexWrap: Wrap = .noWrap,
        justifyContent: JustifyContent = .flexStart,
        alignItems: Alignment = .stretch,
        alignSelf: Alignment = .auto,
        alignContent: Alignment = .flexStart,
        basis: UnitValue = .zero,
        flex: Double = .zero,
        grow: Double = .zero,
        shrink: Double = .zero,
        display: Display = .none,
        size: Size = Size(),
        margin: EdgeValue = .init(left: nil,
                                  top: nil,
                                  right: nil,
                                  bottom: nil,
                                  start: nil,
                                  end: nil,
                                  horizontal: nil,
                                  vertical: nil,
                                  all: UnitValue(value: 0.0, type: .real)),
        padding: EdgeValue = .init(left: nil,
                                   top: nil,
                                   right: nil,
                                   bottom: nil,
                                   start: nil,
                                   end: nil,
                                   horizontal: nil,
                                   vertical: nil,
                                   all: UnitValue(value: 10.0, type: .real)),
        position: EdgeValue = .init(left: nil,
                                    top: nil,
                                    right: nil,
                                    bottom: nil,
                                    start: nil,
                                    end: nil,
                                    horizontal: nil,
                                    vertical: nil,
                                    all: UnitValue(value: 10.0, type: .real))
    ) -> Flex {
        return Flex(direction: direction,
                    flexDirection: flexDirection,
                    flexWrap: flexWrap,
                    justifyContent: justifyContent,
                    alignItems: alignItems,
                    alignSelf: alignSelf,
                    alignContent: alignContent,
                    basis: basis,
                    flex: flex,
                    grow: grow,
                    shrink: shrink,
                    display: display,
                    size: size,
                    margin: margin,
                    padding: padding,
                    position: position
        )
    }
}

// MARK: - Flex Complete Fixture

extension Flex {
    static func fixture(
        direction: Direction = .ltr,
        flexDirection: FlexDirection = .column,
        flexWrap: Wrap = .noWrap,
        justifyContent: JustifyContent = .flexStart,
        alignItems: Alignment = .stretch,
        alignSelf: Alignment = .auto,
        alignContent: Alignment = .flexStart,
        basis: UnitValue = .zero,
        flex: Double = .zero,
        grow: Double = .zero,
        shrink: Double = .zero,
        display: Display = .none,
        size: Size = .init(width: UnitValue(value: 100.0, type: .real),
                           height: UnitValue(value: 100.0, type: .real),
                           maxWidth: UnitValue(value: 100.0, type: .real),
                           maxHeight: UnitValue(value: 100.0, type: .real),
                           minWidth: UnitValue(value: 50.0, type: .real),
                           minHeight: UnitValue(value: 50.0, type: .real),
                           aspectRatio: 30.0),
        margin: EdgeValue = .init(left: UnitValue(value: 10.0, type: .real),
                                  top: UnitValue(value: 10.0, type: .real),
                                  right: UnitValue(value: 10.0, type: .real),
                                  bottom: UnitValue(value: 10.0, type: .real),
                                  start: UnitValue(value: 0.0, type: .real),
                                  end: UnitValue(value: 0.0, type: .real),
                                  horizontal: UnitValue(value: 0.0, type: .real),
                                  vertical: UnitValue(value: 0.0, type: .real),
                                  all: nil),
        padding: EdgeValue = .init(left: UnitValue(value: 10.0, type: .real),
                                   top: UnitValue(value: 10.0, type: .real),
                                   right: UnitValue(value: 10.0, type: .real),
                                   bottom: UnitValue(value: 10.0, type: .real),
                                   start: UnitValue(value: 10.0, type: .real),
                                   end: UnitValue(value: 10.0, type: .real),
                                   horizontal: UnitValue(value: 10.0, type: .real),
                                   vertical: UnitValue(value: 10.0, type: .real),
                                   all: nil),
        position: EdgeValue = .init(left: UnitValue(value: 10.0, type: .real),
                                    top: UnitValue(value: 10.0, type: .real),
                                    right: UnitValue(value: 10.0, type: .real),
                                    bottom: UnitValue(value: 10.0, type: .real),
                                    start: UnitValue(value: 10.0, type: .real),
                                    end: UnitValue(value: 10.0, type: .real),
                                    horizontal: UnitValue(value: 10.0, type: .real),
                                    vertical: UnitValue(value: 10.0, type: .real),
                                    all: nil)
    ) -> Flex {
            return Flex(direction: direction,
                        flexDirection: flexDirection,
                        flexWrap: flexWrap,
                        justifyContent: justifyContent,
                        alignItems: alignItems,
                        alignSelf: alignSelf,
                        alignContent: alignContent,
                        basis: basis,
                        flex: flex,
                        grow: grow,
                        shrink: shrink,
                        display: display,
                        size: size,
                        margin: margin,
                        padding: padding,
                        position: position
            )
    }
}


