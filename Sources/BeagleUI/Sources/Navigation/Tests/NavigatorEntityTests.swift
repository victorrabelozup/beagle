//
//  NavigatorEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Lucas Araújo on 08/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class NavigatorEntityTests: XCTestCase {
    
    func test_whenMapToWidgetIsCalled_thenItShouldReturnANavigator() {
        // Given
        let action = NavigateEntity(type: .addView, path: nil, data: nil)
        let content = TextEntity(text: "text")
        let child = AnyDecodableContainer(content: content)
        let sut = NavigatorEntity(action: action, child: child)
        
        // When
        let flexWidget = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(flexWidget, "Navigator should not be nil.")
        XCTAssertTrue(flexWidget is Navigator)
    }
}
