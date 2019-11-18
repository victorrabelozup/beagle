//
//  NavigationBarEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 18/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class NavigationBarEntityTests: XCTestCase {
    
    func test_whenMapToWidgetIsCalled_thenItShouldReturnANavigationBar() {
        // Given
        let sut = NavigationBarEntity(title: "Iti")
        
        // When
        let navigationBar = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(navigationBar, "The NavigationBar widget should not be nil.")
        XCTAssertTrue(navigationBar is NavigationBar)
    }
    
}
