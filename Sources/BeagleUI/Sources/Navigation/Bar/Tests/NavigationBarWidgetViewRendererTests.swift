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

    private let dependencies = RendererDependenciesContainer()

    // MARK: - Tests
    
    func test_onInitWithNoNavigationBarWidget_shouldReturnThrowError() {
        //Given
        let widget = UnknownWidget()
        
        // When / Then
        XCTAssertThrowsError(
            _ = try NavigationBarWidgetViewRenderer(widget: widget, dependencies: dependencies)
        ) { error in
            XCTAssertNotNil(error, "Expected error, but got \(error.localizedDescription)")
        }
    }
    
    func test_onInitWithNavigationWidget_shouldSetCorrectTitle() throws {
        //Given
        let title = "Teste"
        let widget = NavigationBar(title: title, leading: nil, trailing: nil)
        let context = BeagleContextDummy()
        
        //When
        let renderer = try NavigationBarWidgetViewRenderer(widget: widget, dependencies: dependencies)
        
        guard let navigation = renderer.buildView(context: context) as? UINavigationBar else {
            XCTFail("Build View not returning UINavigationBar")
            return
        }
        
        // Then
        XCTAssertEqual(navigation.topItem?.title, title)
    }

    func test_onInitWithNavigationWidgetWithProperties_shouldSetCorrectly() throws {
        //Given
        let title = "Teste"
        let widget = NavigationBar(title: title, leading: WidgetDummy(), trailing: WidgetDummy())
        let context = BeagleContextDummy()
        
        //When
        let renderer = try NavigationBarWidgetViewRenderer(widget: widget, dependencies: dependencies)
        
        guard let navigation = renderer.buildView(context: context) as? UINavigationBar else {
            XCTFail("Build View not returning UINavigationBar")
            return
        }
        
        // Then
        XCTAssertEqual(navigation.topItem?.title, title)
        XCTAssertNotNil(navigation.items?.count == 3)
    }
    
}

private struct UnknownWidget: Widget { }
