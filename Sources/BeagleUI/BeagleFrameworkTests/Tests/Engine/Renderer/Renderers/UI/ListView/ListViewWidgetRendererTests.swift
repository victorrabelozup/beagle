//
//  ListViewWidgetRendererTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 08/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ListViewWidgetRendererTests: XCTestCase {
    
    func test_buildView_shouldReturnTheExpectedView() {
        // Given
        let expectedPassedFlex = Flex(grow: 1)
        let flexConfiguratorSpy = FlexViewConfiguratorSpy()
        let list = ListView(
            rows: [
                Text("Item 1"),
                Text("Item 2")
            ],
            direction: .vertical
        )
        guard let sut = try? ListViewWidgetRenderer(
            widget: list,
            rendererProvider: WidgetRendererProviderDummy(),
            flexViewConfigurator: flexConfiguratorSpy) else {
                XCTFail("Could not create renderer.")
                return
        }
        let context = BeagleContextDummy()
        
        // When
        let resultingView = sut.buildView(context: context)
        guard let listUIComponent = resultingView as? ListViewUIComponent else {
            XCTFail("Expected `ListViewUIComponent`, but got \(String(describing: resultingView)).")
            return
        }
        let model = Mirror(reflecting: listUIComponent).firstChild(of: ListViewUIComponent.Model.self)
        
        // Then
        XCTAssertNotNil(model, "The model should have been set for `ListViewUIComponent`.")
        XCTAssertEqual(list.rows?.count, model?.widgetViews.count, "Expected \(String(describing: list.rows?.count)) items, but got \(String(describing: model?.widgetViews.count)).")
        XCTAssertTrue(flexConfiguratorSpy.setupFlexCalled, "Expected to call `applyFlex`.")
        XCTAssertEqual(resultingView, flexConfiguratorSpy.viewPassedToSetupFlex, "Expected \(String(describing: resultingView)), but got \(String(describing: flexConfiguratorSpy.viewPassedToSetupFlex)).")
        XCTAssertEqual(expectedPassedFlex.grow, flexConfiguratorSpy.flexPassed?.grow, "Expected \(String(describing: expectedPassedFlex)), but got \(String(describing: flexConfiguratorSpy.flexPassed)).")
        XCTAssertTrue(flexConfiguratorSpy.enableYogaCalled, "Expected to call `applyFlex`.")
        XCTAssertEqual(resultingView, flexConfiguratorSpy.viewPassedToEnableYoga, "Expected \(String(describing: resultingView)), but got \(String(describing: flexConfiguratorSpy.viewPassedToEnableYoga)).")
    }
    
    func test_buildView_withNoRows_shouldReturnTheExpectedView() {
        // Given
        let list = ListView(rows: nil)
        guard let sut = try? ListViewWidgetRenderer(
            widget: list,
            rendererProvider: WidgetRendererProviderDummy(),
            flexViewConfigurator: FlexViewConfiguratorDummy()) else {
                XCTFail("Could not create renderer.")
                return
        }
        let context = BeagleContextDummy()
        
        // When
        let resultingView = sut.buildView(context: context)
        guard let listUIComponent = resultingView as? ListViewUIComponent else {
            XCTFail("Expected `ListViewUIComponent`, but got \(String(describing: resultingView)).")
            return
        }
        let model = Mirror(reflecting: listUIComponent).firstChild(of: ListViewUIComponent.Model.self)
        
        // Then
        XCTAssertNotNil(model, "The model should have been set for `ListViewUIComponent`.")
        XCTAssertEqual(0, model?.widgetViews.count, "Expected `0` items, but got \(String(describing: model?.widgetViews.count)).")
    }
    
}

