//
//  FlexSingleWidgetTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 02/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FlexSingleWidgetTests: XCTestCase {
    
    func test_initWithChild_shouldReturnFlexSingleWidget() {
        // Given / When
        let flexSingleWidget = FlexSingleWidget {
            Text("Some texts")
        }
        // Then
        XCTAssertNotNil(flexSingleWidget.child, "Expected flex single widget to have a child.")
    }
    
    func test_applyFlex_shouldReturnFlexWidget() {
        // Given
        let flex = Flex(justifyContent: .center)
        // When
        let widget = FlexSingleWidget {
            Text("Some texts")
        }
        let flexSingleWidget = widget.applyFlex(flex)
        // Then
        XCTAssertNotNil(flexSingleWidget.flex, "Expected to have a flex widget to have flex attribute, but got none.")
    }
}
