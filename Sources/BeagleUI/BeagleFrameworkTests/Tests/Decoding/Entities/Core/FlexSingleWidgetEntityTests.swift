//
//  FlexSingleWidgetEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 02/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FlexSingleWidgetEntityTests: XCTestCase {
    
    func test_whenMapToWidgetIsCalled_thenItShouldReturnAFlexSingleWidget() {
        // Given
        let content = TextEntity(text: "Some text")
        let child = AnyDecodableContainer(content: content)
        let flex = FlexEntity()
        let sut = FlexSingleWidgetEntity(child: child, flex: flex)
            
        // When
        let flexSingleWidget = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(flexSingleWidget, "Flex widget should not be nil.")
        XCTAssertTrue(flexSingleWidget is FlexSingleWidget)
    }
}
