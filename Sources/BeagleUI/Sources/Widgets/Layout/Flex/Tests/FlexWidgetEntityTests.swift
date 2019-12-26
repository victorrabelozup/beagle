//
//  FlexWidgetEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 02/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FlexWidgetEntityTests: XCTestCase {
    
    func test_whenMapToWidgetIsCalled_thenItShouldReturnAFlexWidget() {
        // Given
        let content = TextEntity(text: "text")
        let children = [AnyDecodableContainer(content: content)]
        let flex = FlexEntity()
        let sut = FlexWidgetEntity(children: children, flex: flex)
        
        // When
        let flexWidget = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(flexWidget, "Flex widget should not be nil.")
        XCTAssertTrue(flexWidget is FlexWidget)
    }
}
