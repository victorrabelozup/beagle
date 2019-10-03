//
//  FlexWidgetTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 02/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FlexWidgetTests: XCTestCase {

    func test_initWithChildren_shouldReturnFlexWidget() {
        // Given / When
        let flexWidget = FlexWidget {
            Text("Some texts")
            Text("More texts")
        }
        // Then
        XCTAssertTrue(flexWidget.children.count > 1, "Expected flex widget to have children.")
    }
    
    func test_initWithOnlyOneChild_shouldReturnFlexWidget() {
        // Given / When
        let flexWidget = FlexWidget {
            Text("Some texts")
        }
        // Then
        XCTAssertTrue(flexWidget.children.count == 1, "Expected flex widget to have children.")
    }

    func test_applyFlex_shouldReturnFlexWidget() {
        // Given
        let flex = Flex(justifyContent: .center)
        // When
        let widget = FlexWidget {
            Text("Some texts")
        }
        let flexWidget = widget.applyFlex(flex)
        // Then
        XCTAssertNotNil(flexWidget.flex, "Expected to have a flex type, but got none.")
    }
    
}
