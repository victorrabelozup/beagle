//
//  ChildrenWidgetMappingTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 19/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ChildrenWidgetMappingTests: XCTestCase {

    func test_whenItHasNoChildrens_thenItShouldReturnAnEmptyArray() {
        // Given
        let stackEntity = StackEntity(childrenContainer: [])
        
        // When
        let children = try? stackEntity.mapChildren()
        
        // Then
        let isEmpty = children?.isEmpty == true
        XCTAssertTrue(isEmpty, "Expected to find an empty Array, but found something.")
    }
    
    func test_whenItHasChildrens_thenItShouldReturnAnArrayWithWidgets() {
        // Given
        let childrenContainer: [WidgetEntityContainer] = [
            WidgetEntityContainer(type: "beagle:Text", content: TextEntity(text: "something"))
        ]
        let stackEntity = StackEntity(childrenContainer: childrenContainer)
        
        // When
        let children = try? stackEntity.mapChildren()
        
        // Then
        let hasOneChild = children?.count == 1
        XCTAssertTrue(hasOneChild, "Expected to find an Array with one child, but found something else.")
    }
    
}
