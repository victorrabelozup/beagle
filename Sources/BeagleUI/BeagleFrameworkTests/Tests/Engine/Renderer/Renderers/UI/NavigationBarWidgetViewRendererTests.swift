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
        XCTAssertThrowsError(_ = try NavigationBarWidgetViewRenderer(widget: widget), "Expected error, but got nil.") { error in
            XCTAssertNotNil(error, "Expected error, but got \(error.localizedDescription)")
        }
    }
    
    func test_onInitWithNavigationWidget_shouldSetCorrectTitle() {
        //Given
        let title = "Teste"
        let widget = NavigationBar(title: title, leading: nil, trailing: nil)
        let context = BeagleContextDummy()
        
        //When
        guard let navigationBarWidgetViewRenderer = try? NavigationBarWidgetViewRenderer(widget: widget) else {
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

    func test_onInitWithNavigationWidgetWithProperties_shouldSetCorrectly() {
        //Given
        let title = "Teste"
        let widget = NavigationBar(title: title, leading: WidgetDummy(), trailing: WidgetDummy())
        let context = BeagleContextDummy()
        
        //When
        guard let navigationBarWidgetViewRenderer = try? NavigationBarWidgetViewRenderer(widget: widget) else {
            XCTFail("Could not render NavigationBar.")
            return
        }
        
        guard let navigation: UINavigationBar = navigationBarWidgetViewRenderer.buildView(context: context) as? UINavigationBar else {
            XCTFail("Build View not returning UINavigationBar")
            return
        }
        
        // Then
        XCTAssertEqual(navigation.topItem?.title, title, "Expected equal titles, but got \(String(describing: navigation.topItem?.title)).")
        XCTAssertNotNil(navigation.items?.count == 3, "Expected three items to be created, but got none.")
    }
    
}

private struct UnknownWidget: NativeWidget { }
