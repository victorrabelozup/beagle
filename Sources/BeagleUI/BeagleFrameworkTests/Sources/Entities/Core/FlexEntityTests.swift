//
//  FlexEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 26/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FlexEntityTests: XCTestCase {

    func test_whenMapToUIModelIsCalled_thenItShouldReturnAValidFlexObject() {
        // Given
        let expectedUIModel = Flex(flexWrap: .no_wrap,
                                   justifyContent: .flex_start,
                                   alignItems: .stretch,
                                   alignSelf: .auto,
                                   alignContent: .flex_start,
                                   basis: UnitValue(value: .zero, type: .real),
                                   grow: 0.0,
                                   shrink: 0)
        let sut = FlexEntity(itemDirection: .ltr,
                             flexWrap: .no_wrap,
                             justifyContent: .flex_start,
                             alignItems: .stretch,
                             alignSelf: .auto,
                             alignContent: .flex_start,
                             basis: UnitValueEntity(value: .zero, type: .real),
                             grow: 0.0,
                             shrink: 0)
        // When
        let uiModel = try? sut.mapToUIModel()
        
        // Then
        XCTAssertEqual(uiModel, expectedUIModel, "Expected \(expectedUIModel), but got \(uiModel.debugDescription)")
    }

    func test_whenDecodingAValidJSON_itShouldReturnAValidObjec() {
        // Given
        let json = """
        {
            "type": "beagle:Horizontal",
            "flex": {
                "justifyContent": "FLEX_START"
            },
            "children": [
                {
                    "type": "beagle:Text",
                    "text": "FREE"
                }
            ]
        }
        """
        guard let jsonData = json.data(using: .utf8) else {
            XCTFail("Could not create JSON data.")
            return
        }
        // When
       // let uiModelObject = try?
        let object = try? WidgetDecoder().decode(from: jsonData)
        // Then
        XCTAssertNotNil(object, "Expected a valid object, but found nil.")

    }

}

extension Flex: Equatable {
    public static func == (lhs: Flex, rhs: Flex) -> Bool {
        return lhs.alignContent == rhs.alignContent &&
            lhs.alignItems == rhs.alignItems &&
            lhs.alignSelf == rhs.alignSelf &&
            lhs.basis == rhs.basis &&
            lhs.flexWrap == rhs.flexWrap &&
            lhs.grow == rhs.grow &&
            lhs.justifyContent == rhs.justifyContent
    }
}
