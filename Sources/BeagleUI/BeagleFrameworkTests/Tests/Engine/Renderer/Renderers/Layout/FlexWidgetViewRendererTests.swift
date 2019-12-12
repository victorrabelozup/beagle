//
//  FlexWidgetViewRendererTests.swift
//  BeagleFrameworkTests
//
//  Created by Yan Dias on 17/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FlexWidgetViewRendererTests: XCTestCase {
    
    func test_buildView_shouldReturnTheExpectedView() {
        //Given
        let flexSpy = FlexViewConfiguratorSpy()
        let dependencies = RendererDependenciesContainer(flex: flexSpy)

        let numberOfChilds = 3
        let flexWidgetChilds = Array(repeating: WidgetDummy(), count: numberOfChilds)
        let flexWidget = FlexWidget(children: flexWidgetChilds)

        guard let renderer = try? FlexWidgetViewRenderer(
            widget: flexWidget,
            dependencies: dependencies
        ) else {
            XCTFail()
            return
        }
        let context = BeagleContextDummy()
        
        // When
        let resultingView = renderer.buildView(context: context)
        
        //Then
        XCTAssertTrue(flexSpy.setupFlexCalled, "Expected to call `applyFlex`.")
        XCTAssertEqual(resultingView, flexSpy.viewPassedToSetupFlex, "Expected \(String(describing: resultingView)), but got \(String(describing: flexSpy.viewPassedToSetupFlex)).")
        XCTAssertEqual(flexWidget.flex.size?.height, flexSpy.flexPassed?.size?.height,"Expected \(String(describing: flexWidget.flex.size?.height)), but got \(String(describing: flexSpy.flexPassed?.size?.height)).")
        XCTAssertEqual(flexWidget.flex.size?.width, flexSpy.flexPassed?.size?.width,"Expected \(String(describing: flexWidget.flex.size?.width)), but got \(String(describing: flexSpy.flexPassed?.size?.width)).")
        XCTAssertEqual(resultingView.subviews.count, numberOfChilds, "Expected \(numberOfChilds) subview, but got \(resultingView.subviews.count).")
        
    }
}
