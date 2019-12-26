//
//  ScrollViewWidgetViewRendererTests.swift
//  BeagleFrameworkTests
//
//  Created by Tarcisio Clemente on 08/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ScrollViewWidgetViewRendererTests: XCTestCase {
    
    func test_buildView_shouldReturnTheExpectedView() {
        // Given
        let flexSpy = FlexViewConfiguratorSpy()
        let dependencies = RendererDependenciesContainer(flex: flexSpy)
        
        let container = ScrollView {
            WidgetDummy()
        }

        guard let renderer = try? ScrollViewWidgetViewRenderer(
            widget: container,
            dependencies: dependencies
        ) else {
            XCTFail("Could not create renderer.")
            return
        }
        
        // When
        let resultingView = renderer.buildView(context: BeagleContextDummy())
        
        // Then
        XCTAssertTrue(flexSpy.setupFlexCalled, "Expected to call `applyFlex`.")
        XCTAssertTrue(resultingView.subviews.count == 1, "Expected view to have 1 subviews, but has \(resultingView.subviews)")
        XCTAssertEqual(flexSpy.timesPassed, 1, "Expected 3, but got \(String(describing: flexSpy.timesPassed)).")
    }
    
    func test_whenLayoutSubViewsIsCalledOnBagleContainerScrollView_itShouldSetupTheContentSizeCorrectly() {
        // Given
        let subview = UIView(frame: .init(x: 0, y: 0, width: 100, height: 100))
        let sut = BeagleContainerScrollView()
        sut.addSubview(subview)

        // When
        sut.layoutSubviews()

        // Then
        XCTAssertEqual(subview.frame.size, sut.contentSize, "Expected \(subview.frame.size), but got \(sut.contentSize).")
        
    }
    
}
