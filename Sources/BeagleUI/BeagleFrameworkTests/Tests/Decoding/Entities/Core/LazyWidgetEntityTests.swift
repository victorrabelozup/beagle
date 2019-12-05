//
//  LazyWidgetEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Lucas Araújo on 27/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class LazyWidgetEntityTests: XCTestCase {
    
    func test_whenMapToWidgetIsCalled_thenItShouldReturnALazyWidget() {
        // Given
        let content = TextEntity(text: "text")
        let initialState = AnyDecodableContainer(content: content)
        let sut = LazyWidgetEntity(url: "content", initialState: initialState)
        
        // When
        let widget = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(widget, "LazyWidget should not be nil.")
        XCTAssertTrue(widget is LazyWidget)
    }
    
    func test_whenInitialStateContentIsNotWidget_itShouldMapToAnyWidget() {
        // Given
        let initialState = AnyDecodableContainer(content: 0)
        let sut = LazyWidgetEntity(url: "content", initialState: initialState)
        
        // When
        let widget = try? sut.mapToWidget() as? LazyWidget
        
        // Then
        XCTAssertTrue(widget?.initialState is AnyWidget)
    }
}
