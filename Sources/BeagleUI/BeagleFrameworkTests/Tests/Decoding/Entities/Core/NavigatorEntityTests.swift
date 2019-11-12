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
        let child = WidgetEntityContainer(type: "beagle:Text", content: content)
        guard let sut = try? NavigatorEntity(action: action, childContainer: child) else {
            XCTFail("Could not create Navigator widget.")
            return
        }
        
        // When
        let flexWidget = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(flexWidget, "Navigator should not be nil.")
        XCTAssertTrue(flexWidget is Navigator)
    }
    
    func test_whenDecodingAValidJson_itShouldReturnAValidObject() {
        // Given
        let json = """
            {
                "_beagleType_": "beagle:widget:Navigator",
                "action": {
                    "type": "ADD_VIEW",
                    "path": "product.json"
                },
                "child": {
                    "_beagleType_": "beagle:widget:Button",
                    "text": "Product"
                }
            }
        """
        guard let jsonData = json.data(using: .utf8) else {
            XCTFail("Could not create Navigator JSON data.")
            return
        }
        
        // When
        let object = try? WidgetDecoder().decodeToWidget(ofType: Navigator.self, from: jsonData)
        
        // Then
        XCTAssertNotNil(object, "Expected a valid object, but found nil.")
        XCTAssertEqual(object?.action.type, .addView, "Expected action type to be `.addView`")
        XCTAssertEqual(object?.action.path, "product.json", "Expected action path to be `product.json`")
        XCTAssertTrue(object?.child is Button, "Expected object child to be a Button")
    }
    
    func test_whenDecodingAUnknowChildWidget_itShouldReturnAValidObject() {
        // Given
        let json = """
            {
                "_beagleType_": "beagle:widget:Navigator",
                "action": {
                    "type": "ADD_VIEW",
                    "path": "product.json"
                },
                "child": {
                    "_beagleType_": "beagle:unknow:XYZ",
                    "text": "Product"
                }
            }
        """
        guard let jsonData = json.data(using: .utf8) else {
            XCTFail("Could not create Navigator JSON data.")
            return
        }
        
        // When
        let object = try? WidgetDecoder().decodeToWidget(ofType: Navigator.self, from: jsonData)
        
        // Then
        XCTAssertNil(object, "Expected object to be nil")
    }
    
}
