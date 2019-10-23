//
//  FlexViewConfiguratorTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 14/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
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
    
//    func test_flexWithAttributeAllSet_shouldSetPropertiesProperly() {
//        // Given
//        let sut = FlexViewConfigurator()
//        let flex = Flex.fixtureWithAll()
//        let button = UIButton()
//        
//        // When
//        sut.applyFlex(flex, to: button)
//        
//        // Then
//        XCTAssertNotNil(flex.margin, "Expected flex margin properties setted, but got nil.")
//        XCTAssertNotNil(flex.padding, "Expected flex padding properties setted, but got nil.")
//        XCTAssertNotNil(flex.position, "Expected flex position properties setted, but got nil.")
//    }
//    
//    func test_flexWithEveryPropertySet_shouldSetPropertiesProperly() {
//        // Given
//        let sut = FlexViewConfigurator()
//        let flex = Flex.fixture()
//        let button = UIButton()
//        
//        // When
//        sut.applyFlex(flex, to: button)
//        
//        // Then
//        XCTAssertNotNil(flex.size, "Expected flex size properties setted, but got nil.")
//        XCTAssertNotNil(flex.margin, "Expected flex margin properties setted, but got nil.")
//        XCTAssertNotNil(flex.padding, "Expected flex padding properties setted, but got nil.")
//        XCTAssertNotNil(flex.position, "Expected flex position properties setted, but got nil.")
//    }
}

