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
        let flexSpy = FlexViewConfiguratorSpy()
        let list = ListView(
            rows: [
                Text("Item 1"),
                Text("Item 2")
            ],
            direction: .vertical
        )

        let dependencies = RendererDependenciesContainer(
            flex: flexSpy
        )

        guard let sut = try? ListViewWidgetRenderer(
            widget: list,
            dependencies: dependencies
        ) else {
            XCTFail("Could not create renderer.")
            return
        }
        
        // When
        let resultingView = sut.buildView(context: BeagleContextDummy())
        guard let listUIComponent = resultingView as? ListViewUIComponent else {
            XCTFail("Expected `ListViewUIComponent`, but got \(String(describing: resultingView)).")
            return
        }
        let model = Mirror(reflecting: listUIComponent).firstChild(of: ListViewUIComponent.Model.self)
        
        // Then
        XCTAssertNotNil(model, "The model should have been set for `ListViewUIComponent`.")
        XCTAssertEqual(list.rows?.count, model?.widgetViews.count, "Expected \(String(describing: list.rows?.count)) items, but got \(String(describing: model?.widgetViews.count)).")
        XCTAssertTrue(flexSpy.setupFlexCalled, "Expected to call `applyFlex`.")
        XCTAssertEqual(resultingView, flexSpy.viewPassedToSetupFlex, "Expected \(String(describing: resultingView)), but got \(String(describing: flexSpy.viewPassedToSetupFlex)).")
        XCTAssertEqual(expectedPassedFlex.grow, flexSpy.flexPassed?.grow, "Expected \(String(describing: expectedPassedFlex)), but got \(String(describing: flexSpy.flexPassed)).")
        XCTAssertTrue(flexSpy.enableYogaCalled, "Expected to call `applyFlex`.")
        XCTAssertEqual(resultingView, flexSpy.viewPassedToEnableYoga, "Expected \(String(describing: resultingView)), but got \(String(describing: flexSpy.viewPassedToEnableYoga)).")
    }
    
    func test_buildView_withNoRows_shouldReturnTheExpectedView() {
        // Given
        let list = ListView(rows: nil)
        let dependencies = RendererDependenciesContainer(
            flex: FlexViewConfiguratorDummy(),
            rendererProvider: WidgetRendererProviderDummy()
        )

        guard let sut = try? ListViewWidgetRenderer(
            widget: list,
            dependencies: dependencies
        ) else {
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

