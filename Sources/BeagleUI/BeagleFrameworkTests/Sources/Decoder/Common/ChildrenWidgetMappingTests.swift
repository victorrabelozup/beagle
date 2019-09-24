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

    private lazy var widgetDecoder = WidgetDecoder()

    func test_whenMapChildrenFunctionIsCalled_thenItDoesntFindAnyChildrenForType() {
        // Given
        guard let stackWidgetMock = buildStackEntityMock(for: .noChildren) else {
            return
        }
        // When
        let children = try? stackWidgetMock.mapChildren()
        // Then
        XCTAssertNil(children, "Expected nil, but found something.")
    }

    func test_whenItHasChildren_thenItsContentIsEmptyForContainer() {
        // Given
        guard let stackWidgetMock = buildStackEntityMock(for: .childrenContentEmpty) else {
            return
        }
        // When
        let children = try? stackWidgetMock.mapChildren()
        // Then
        XCTAssertNil(children, "Expected nil for children content.")
    }
    
    func test_whenItHasChildren_thenItMapsChildrenPropertiesAsWidgets() {
        // Given
        guard let stackWidgetMock = buildStackEntityMock(for: .hasChildrenWidgets) else {
            return
        }
        // When
        guard let children = try? stackWidgetMock.mapChildren() else {
            XCTFail("Expected children to have values.")
            return
        }
        // Then
        XCTAssertNotNil(children, "Expected a mapping of the children to widgets.")
        XCTAssertTrue(children.count > 0, "Expected children to be an array of Widget type")
    }
}

// MARK: - ChildrenWidgetMapping Test JsonData
private extension ChildrenWidgetMappingTests {
    
    enum StackEntityMock {
        case noChildren
        case childrenContentEmpty
        case hasChildrenWidgets
    }
    
    func getJsonDataForMock(_ cases: StackEntityMock) -> Data? {
        var jsonData: Data?
        switch cases {
        case .noChildren:
            jsonData = """
            {
                "type": "beagle:Stack"
            }
            """.data(using: .utf8)
        case .childrenContentEmpty:
            jsonData = """
            {
                "type": "beagle:Stack",
                "children": []
            }
            """.data(using: .utf8)
        case .hasChildrenWidgets:
            jsonData = """
            {
                "type": "beagle:Stack",
                "children": [
                    {
                        "type": "beagle:Text",
                        "text": "some text"
                    },
                    {
                        "type": "beagle:Text",
                        "text": "some text 2"
                    }
                ]
            }
            """.data(using: .utf8)
        }
        return jsonData
    }
    
    func buildStackEntityMock(for mockCase: StackEntityMock) -> StackEntity? {
        guard let jsonData = getJsonDataForMock(mockCase) else {
            XCTFail("Could not create test data.")
            return nil
        }
        let transformer: (WidgetEntity) -> StackEntity? = { $0 as? StackEntity }
        guard let value = try? widgetDecoder.decode(from: jsonData, transformer: transformer) else {
            XCTFail("Could not decode test data.")
            return nil
        }
        return value
    }
}
