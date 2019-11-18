//
//  NavigationBarWidgetViewRendererTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 18/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class NavigationBarWidgetViewRendererTests: XCTestCase {

    // MARK: - Tests
    
    func test_onInitWithNoNavigationBarWidget_shouldReturnThrowError() {
        //Given
        let widget = UnknownWidget()
        
        // When / Then
        XCTAssertThrowsError(_ = try NavigationBarWidgetViewRenderer(widget), "Expected error, but got nil.") { error in
            XCTAssertNotNil(error, "Expected error, but got \(error.localizedDescription)")
        }
    }
    
    func test_onInitWithNavigationWidget_shouldSetCorrectTitle() {
        //Given
        let title = "Iti"
        let widget = NavigationBar(title: title)
        let context = BeagleContextDummy()
        
        //When
        guard let navigationBarWidgetViewRenderer = try? NavigationBarWidgetViewRenderer(widget) else {
            XCTFail("Could not render NavigationBar.")
            return
        }
        
        guard let navigation: UINavigationBar = navigationBarWidgetViewRenderer.buildView(context: context) as? UINavigationBar else {
            XCTFail("Build View not returning UINavigationBar")
            return
        }
        
        // Then
        XCTAssertEqual(navigation.topItem?.title, title, "Expected equal titles, but got \(String(describing: navigation.topItem?.title)).")
    }

}

private struct UnknownWidget: NativeWidget { }
