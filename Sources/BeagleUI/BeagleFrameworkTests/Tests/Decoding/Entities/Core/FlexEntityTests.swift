//
//  FlexEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 04/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FlexEntityTests: XCTestCase {
    
    func test_whenDecodingAValidJson_itShouldReturnAValidFlexEntityObject() {
        
        // Given
        let json = """
             {
                "itemDirection": "LTR",
                "flexWrap": "NO_WRAP",
                "justifyContent": "FLEX_START",
                "alignItems": "STRETCH",
                "alignSelf": "FLEX_START",
                "alignContent": "AUTO",
                "basis": {
                    "value": 0.0,
                    "type": "real"
                },
                "grow": 0.0,
                "shrink": 0
             }
         """
        guard let jsonData = json.data(using: .utf8) else {
            XCTFail("Could not create JSON data.")
            return
        }
        
        // When
        let object = decodingFlexEntityHelper(jsonData: jsonData)
        
        // Then
        XCTAssertNotNil(object, "Expected a valid object, but found nil.")
    }
    
    func test_whenDecodingNullValueJson_itShouldReturnFlexEntityWithDefaultValues() {
        
        // Given
        let json = """
             {
                "itemDirection": null,
                "flexWrap": null,
                "justifyContent": null,
                "alignItems": null,
                "alignSelf": null,
                "alignContent": null
             }
         """
        guard let jsonData = json.data(using: .utf8) else {
            XCTFail("Could not create JSON data.")
            return
        }
        
        // When
        let object = decodingFlexEntityHelper(jsonData: jsonData)
        
        // Then
        XCTAssertNotNil(object, "Expected a valid object, but found nil.")
        XCTAssertNotNil(object?.alignItems, "Expected object to have initialized with default value, but it hasn't.")
    }
    
    func test_whenDecodingEmptyValueJson_itShouldReturnFlexEntityWithDefaultValues() {
        
        // Given
        let json = """
             {}
         """
        guard let jsonData = json.data(using: .utf8) else {
            XCTFail("Could not create JSON data.")
            return
        }
        
        // When
        let object = decodingFlexEntityHelper(jsonData: jsonData)
        
        // Then
        XCTAssertNotNil(object, "Expected a valid object, but found nil.")
        XCTAssertNotNil(object?.alignItems, "Expected object to have initialized with default value, but it hasn't.")
    }
    
}

// MARK: - FlexEntity Decoding Helper
private extension FlexEntityTests {
    func decodingFlexEntityHelper(jsonData: Data) -> FlexEntity? {
        var object: FlexEntity?
        do {
            object = try JSONDecoder().decode(FlexEntity.self, from: jsonData)
        } catch {
            XCTFail("Unable to decode JSON. Got \(error.localizedDescription)")
        }
        return object
    }
}
