//
//  SpacerWidgetViewRendererTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 16/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class SpacerWidgetViewRendererTests: XCTestCase {
    
    func test_buildView_shouldReturnTheExpectedView() {
        // Given
        let flexConfiguratorSpy = FlexViewConfiguratorSpy()
        let spacer = Spacer(1.0)
        guard let renderer = try? SpacerWidgetViewRenderer(
            widget: spacer,
            rendererProvider: WidgetRendererProviderDummy(),
            flexViewConfigurator: flexConfiguratorSpy
        ) else {
            XCTFail("Could not create renderer.")
            return
        }
        
        // When
        let resultingView = renderer.buildView()
    
        // Then
        XCTAssertTrue(flexConfiguratorSpy.setupFlexCalled, "Expected to call `applyFlex`.")
        XCTAssertEqual(spacer.size, flexConfiguratorSpy.flexPassed?.size?.width?.value, "Expected \(spacer.size), but got \(String(describing: flexConfiguratorSpy.flexPassed?.size?.width?.value)).")
        XCTAssertEqual(spacer.size, flexConfiguratorSpy.flexPassed?.size?.height?.value, "Expected \(spacer.size), but got \(String(describing: flexConfiguratorSpy.flexPassed?.size?.height?.value)).")
        XCTAssertEqual(resultingView, flexConfiguratorSpy.viewPassedToSetupFlex, "Expected \(String(describing: resultingView)), but got \(String(describing: flexConfiguratorSpy.viewPassedToSetupFlex)).")
    }
    
    
    
}
