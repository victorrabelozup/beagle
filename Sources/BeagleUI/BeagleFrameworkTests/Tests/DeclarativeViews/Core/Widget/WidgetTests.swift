//
//  WidgetTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 25/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class WidgetTests: XCTestCase {

    func test_whenBuildingNativeWidget_shouldThrowError() {
        // Given
        let nativeWidget = NativeWidgetDummy()
        let expectedError = "NativeWidgets don't need to be built!"
        // When/ Then
        XCTAssertThrowsError(try nativeWidget.build(), "Expected error, but got none.") { (error) in
            XCTAssert(error.localizedDescription == expectedError, "Expected error to be \(expectedError), but got \(error.localizedDescription).")
        }
    }

    func test_whenBuildingAnyWidget_shouldThrowError() {
        // Given
        let anyWidget = AnyWidget(value: "")
        let expectedError = "NativeWidgets don't need to be built!"
        // When/ Then
        XCTAssertThrowsError(try anyWidget.build(), "Expected error, but got none.") { (error) in
            XCTAssert(error.localizedDescription == expectedError, "Expected error to be \(expectedError), but got \(error.localizedDescription).")
        }
    }
    
    func test_whenBuildAnyWidget_shouldBuild() {
        // Given
        let anyWidget = AnyWidget(value: AnyWidgetDummy())
        // When
        let widgetBuilt = try? anyWidget.build()
        // Then
        XCTAssertNotNil(widgetBuilt, "Expected widget to be built, but got none.")
    }
}

private struct NativeWidgetDummy: NativeWidget {}

private struct AnyWidgetDummy: Widget {
    func build() throws -> Widget {
        return self
    }
}
