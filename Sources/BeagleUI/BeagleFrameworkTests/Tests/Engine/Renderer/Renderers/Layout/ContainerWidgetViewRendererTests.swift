//
//  ContainerWidgetViewRendererTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 17/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ContainerWidgetViewRendererTests: XCTestCase {
    
    func test_buildView_shouldReturnTheExpectedView() {
        // Given
        let flexConfiguratorSpy = FlexViewConfiguratorSpy()
        let container = Container(header: WidgetDummy(), content: WidgetDummy(), footer: WidgetDummy())
        guard let renderer = try? ContainerWidgetViewRenderer(
            widget: container,
            rendererProvider: WidgetRendererProviderDummy(),
            flexViewConfigurator: flexConfiguratorSpy) else {
                XCTFail("Could not create renderer.")
                return
        }
        
        // When
        let resultingView = renderer.buildView()
        
        // Then
        XCTAssertTrue(flexConfiguratorSpy.applyFlexCalled, "Expected to call `applyFlex`.")
        XCTAssertTrue(flexConfiguratorSpy.configFlexCalled, "Expected to call `configFlex` function.")
        XCTAssertEqual(Flex.FlexDirection.column, flexConfiguratorSpy.flexPassed?.flexDirection, "Expected flex to have column as a flexDirection, but got \(String(describing: flexConfiguratorSpy.flexPassed?.flexDirection)).")
        XCTAssertEqual(Flex.JustifyContent.spaceBetween, flexConfiguratorSpy.flexPassed?.justifyContent, "Expected flex to have spaceBetween as a justifyContent, but got \(String(describing: flexConfiguratorSpy.flexPassed?.justifyContent)).")
        XCTAssertEqual(resultingView, flexConfiguratorSpy.viewPassed, "Expected \(String(describing: resultingView)), but got \(String(describing: flexConfiguratorSpy.viewPassed)).")
        XCTAssertTrue(resultingView.subviews.count == 3, "Expected view to have 3 subviews, a header, a content and a footer, but has \(resultingView.subviews)")
    }
}

// MARK: - Testing Helpers

private final class WidgetViewRendererProtocolDummy: WidgetViewRendererProtocol {
    init() { }
    init(_ widget: Widget) throws {}
    func buildView() -> UIView { return UIView() }
}

private class WidgetRendererProviderDummy: WidgetRendererProvider {
    func buildRenderer(for widget: Widget) -> WidgetViewRendererProtocol {
        return WidgetViewRendererProtocolDummy()
    }
}
