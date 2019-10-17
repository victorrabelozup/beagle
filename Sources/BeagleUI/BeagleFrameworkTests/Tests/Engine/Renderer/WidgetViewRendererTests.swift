//
//  WidgetViewRendererTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 16/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class WidgetViewRendererTests: XCTestCase {
    
    func test_whenInit_dependenciesShouldBeConfiguredProperly() {
        // Given
        let environmentSpy = BeagleEnvironmentSpy.self
        Beagle.environment = environmentSpy
        Beagle.start()
        let spacer = Spacer(1.0)
        
        // When
        guard let renderer = try? WidgetViewRenderer<Spacer>(spacer) else {
            XCTFail("Could not create renderer.")
            return
        }
        let mirror = Mirror(reflecting: renderer)
        let widget = mirror.firstChild(of: Spacer.self)
        let rendererProvider = mirror.firstChild(of: WidgetRendererProviding.self)
        let flexViewConfigurator = mirror.firstChild(of: FlexViewConfigurator.self)
        
        // Then
        XCTAssertNotNil(widget, "Expected `Spacer` but got nil.")
        XCTAssertNotNil(rendererProvider, "Expected `WidgetRendererProviding` but got nil.")
        XCTAssertNotNil(flexViewConfigurator, "Expected `FlexViewConfigurator` but got nil.")
    }
    
}
