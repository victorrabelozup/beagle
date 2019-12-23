//
//  TabViewEntityTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 28/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class TabViewEntityTests: XCTestCase {
    func test_whenMapToWidgetIsCalled_thenItShouldReturnTabView() {
        // Given
        let buttonEntity = ButtonEntity(text: "button", style: "")
        let tabsEntity = TabItemEntity(icon: "", title: "Teste", content: AnyDecodableContainer(content: buttonEntity))
        let tabItems = [AnyDecodableContainer(content: tabsEntity)]
        let sut = TabViewEntity(tabItems: tabItems)
        
        // When
        let tabView = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(tabView, "The TabBar widget should not be nil.")
        XCTAssertTrue(tabView is TabView)
    }
    
    func test_whenGettingWidgetFromJson_thenItShouldReturnTabView() {
        // Given /When
        guard let widget: TabView = try? widgetFromJsonFile(fileName: "TabView") else {
            XCTFail("Unable to get Tab View Widget from json File.")
            return
        }

        // Then
        XCTAssertNotNil(widget, "The TabBar widget should not be nil.")
    }
}
