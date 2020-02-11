//
//  LazyComponentEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Lucas Araújo on 27/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class LazyComponentEntityTests: XCTestCase {
    
    func test_whenMapToComponentIsCalled_thenItShouldReturnALazyComponent() {
        // Given
        let content = TextEntity(text: "text")
        let initialState = AnyDecodableContainer(content: content)
        let sut = LazyComponentEntity(url: "content", initialState: initialState)
        
        // When
        let component = try? sut.mapToComponent()
        
        // Then
        XCTAssertNotNil(component)
        XCTAssert(component is LazyComponent)
    }
    
    func test_whenInitialStateContentIsNotComponent_itShouldMapToAnyComponent() {
        // Given
        let initialState = AnyDecodableContainer(content: 0)
        let sut = LazyComponentEntity(url: "content", initialState: initialState)
        
        // When
        let component = try? sut.mapToComponent() as? LazyComponent
        
        // Then
        XCTAssert(component??.initialState is AnyComponent)
    }
}
