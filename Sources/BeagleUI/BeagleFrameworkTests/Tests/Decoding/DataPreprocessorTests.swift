//
//  DataPreprocessorTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 24/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class DataPreprocessorTests: XCTestCase {

    func test_whenProcessingValidData_itShouldReturnTheExpectedNormalizedValue() {
        // Given
        let json = """
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
        """
        guard let jsonData = json.data(using: .utf8) else {
            XCTFail("Could not create JSON data.")
            return
        }
        guard let expectedJSONData = """
            {
                "type": "beagle:Stack",
                "content": {
                    "children": [
                        {
                            "type": "beagle:Text",
                            "content": {
                                "text": "some text"
                            }
                        },
                        {
                            "type": "beagle:Text",
                            "content": {
                                "text": "some text 2"
                            }
                        }
                    ]
                }
            }
        """.data(using: .utf8),
        let expectedJSONValues = try? JSONSerialization.jsonObject(with: expectedJSONData, options: .mutableContainers) as? NSDictionary else {
            XCTFail("Could not create expectedJSONValues.")
            return
        }
        let sut = DataPreprocessing()
        
        // When
        guard let normalizedData = try? sut.normalizeData(jsonData, for: ["Beagle"]) else {
            XCTFail("Could not normalize Data!")
            return
        }
        guard let normalizedDataAsJSONValues = try? JSONSerialization.jsonObject(with: normalizedData, options: .mutableContainers) as? [String: Any] else {
            XCTFail("Could not create normalizedDataAsJSONValues.")
            return
        }
        
        // Then
        let areDictionariesEqual = expectedJSONValues.isEqual(to: normalizedDataAsJSONValues)
        XCTAssertTrue(areDictionariesEqual, "The dictionaries should be equal.")
    }
    
    func test_whenProcessingInvalidData_itShouldThrowJSONSerializationError() {
        // Given
        let json = """
        {
            "type": "beagle:Stack",
            children": [
                {
                    "type": "beagle:Text",
                    "text": "some text 2"
            ]
        }
        """
        guard let jsonData = json.data(using: .utf8) else {
            XCTFail("Could not create JSON data.")
            return
        }
        
        let sut = DataPreprocessing()
        
        // When / Then
        XCTAssertThrowsError(
            try sut.normalizeData(jsonData, for: ["Beagle"]),
            "Invalid data should throw error."
        )
    }
    
}
