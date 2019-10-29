//
//  FlexViewConfiguratorTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 14/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
import YogaKit
@testable import BeagleUI

final class FlexViewConfiguratorTests: XCTestCase {
    
    func test_init_shouldReturnInstanceWithYogaTranslatorDependencySetProperly() {
        // Given
        let sut = FlexViewConfigurator(yogaTranslator: YogaTranslating())
        let mirror = Mirror(reflecting: sut)
        // When
        let yogaTranslator = mirror.firstChild(of: YogaTranslating.self)
        // Then
        XCTAssertNotNil(yogaTranslator, "Expected a valid instance of Yoga Translating type, but got nil.")
    }
    
    func test_setupFlex_shouldApplyDefaultYogaPropertiesProperly() {
        // Given
        let sut = FlexViewConfigurator(yogaTranslator: YogaTranslating())
        let flex = Flex()
        let view = UIView()
        // When
        sut.setupFlex(flex, for: view)
        // Then
        XCTAssertEqual(view.yoga.direction, .LTR)
        XCTAssertEqual(view.yoga.flexDirection, .column)
        XCTAssertEqual(view.yoga.flexWrap, .noWrap)
        XCTAssertEqual(view.yoga.justifyContent, .flexStart)
        XCTAssertEqual(view.yoga.alignItems, .stretch)
        XCTAssertEqual(view.yoga.alignSelf, .auto)
        XCTAssertEqual(view.yoga.alignContent, .flexStart)
        XCTAssertEqual(view.yoga.position, .relative)
        XCTAssertEqual(view.yoga.flexBasis.unit, .auto)
        XCTAssertEqual(view.yoga.flex, 0)
        XCTAssertEqual(view.yoga.flexGrow, 0)
        XCTAssertEqual(view.yoga.flexShrink, 1)
        XCTAssertEqual(view.yoga.display, .flex)
    }
    
    func test_setupFlex_shouldApplyAllYogaPropertiesProperly() {
        // Given
        let sut = FlexViewConfigurator(yogaTranslator: YogaTranslating())
        let size = Flex.Size(
            width: UnitValue(value: 1, type: .real),
            height: UnitValue(value: 1, type: .real),
            maxWidth: UnitValue(value: 1, type: .real),
            maxHeight: UnitValue(value: 1, type: .real),
            minWidth: UnitValue(value: 1, type: .real),
            minHeight: UnitValue(value: 1, type: .real),
            aspectRatio: 1
        )
        let edgeValue = Flex.EdgeValue(
            left: UnitValue(value: 1, type: .real),
            top: UnitValue(value: 1, type: .real),
            right: UnitValue(value: 1, type: .real),
            bottom: UnitValue(value: 1, type: .real),
            start: UnitValue(value: 1, type: .real),
            end: UnitValue(value: 1, type: .real),
            horizontal: UnitValue(value: 1, type: .real),
            vertical: UnitValue(value: 1, type: .real),
            all: UnitValue(value: 1, type: .real)
        )
        let flex = Flex(
            size: size,
            margin: edgeValue,
            padding: edgeValue,
            position: edgeValue
        )
        let expectedYGValue = YGValue(value: 1, unit: .point)
        let view = UIView()
        // When
        sut.setupFlex(flex, for: view)
        // Then
        XCTAssertEqual(view.yoga.width, expectedYGValue)
        XCTAssertEqual(view.yoga.height, expectedYGValue)
        XCTAssertEqual(view.yoga.maxWidth, expectedYGValue)
        XCTAssertEqual(view.yoga.maxHeight, expectedYGValue)
        XCTAssertEqual(view.yoga.minWidth, expectedYGValue)
        XCTAssertEqual(view.yoga.minHeight, expectedYGValue)
        XCTAssertEqual(view.yoga.aspectRatio, 1)
        
        XCTAssertEqual(view.yoga.marginLeft, expectedYGValue)
        XCTAssertEqual(view.yoga.marginTop, expectedYGValue)
        XCTAssertEqual(view.yoga.marginRight, expectedYGValue)
        XCTAssertEqual(view.yoga.marginBottom, expectedYGValue)
        XCTAssertEqual(view.yoga.marginStart, expectedYGValue)
        XCTAssertEqual(view.yoga.marginEnd, expectedYGValue)
        XCTAssertEqual(view.yoga.marginHorizontal, expectedYGValue)
        XCTAssertEqual(view.yoga.marginVertical, expectedYGValue)
        XCTAssertEqual(view.yoga.margin, expectedYGValue)
        
        XCTAssertEqual(view.yoga.paddingLeft, expectedYGValue)
        XCTAssertEqual(view.yoga.paddingTop, expectedYGValue)
        XCTAssertEqual(view.yoga.paddingRight, expectedYGValue)
        XCTAssertEqual(view.yoga.paddingBottom, expectedYGValue)
        XCTAssertEqual(view.yoga.paddingStart, expectedYGValue)
        XCTAssertEqual(view.yoga.paddingEnd, expectedYGValue)
        XCTAssertEqual(view.yoga.paddingHorizontal, expectedYGValue)
        XCTAssertEqual(view.yoga.paddingVertical, expectedYGValue)
        XCTAssertEqual(view.yoga.padding, expectedYGValue)
        
        XCTAssertEqual(view.yoga.left, expectedYGValue)
        XCTAssertEqual(view.yoga.top, expectedYGValue)
        XCTAssertEqual(view.yoga.right, expectedYGValue)
        XCTAssertEqual(view.yoga.bottom, expectedYGValue)
        XCTAssertEqual(view.yoga.start, expectedYGValue)
        XCTAssertEqual(view.yoga.end, expectedYGValue)
    }
}
