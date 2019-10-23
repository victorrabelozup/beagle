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
    
    func test_initWithChild_shouldReturnFlexSingleWidgetAndSetDependenciesProperly() {
        // Given
        let sut = FlexSingleWidget(child: Text("Teste"), flex: Flex())
        let mirror = Mirror(reflecting: sut)
        // When
        let flex = mirror.firstChild(of: Flex.self)
        let widget = mirror.firstChild(of: Widget.self)
        // Then
        XCTAssertNotNil(flex, "Expected a valid instance of type `Flex`, but got nil.")
        XCTAssertNotNil(widget, "Expected a valid instance of type `Widget`, but got nil.")
        
    }
    
    func test_applyFlex_shouldReturnFlexWidget() {
        // Given
        let widget = FlexSingleWidget {
            Text("Some texts")
        }
        // When
        let flexSingleWidget = widget.applyFlex(justifyContent: .center)
        // Then
        XCTAssertNotNil(flexSingleWidget.flex, "Expected to have a flex widget to have flex attribute, but got none.")
    }
}
