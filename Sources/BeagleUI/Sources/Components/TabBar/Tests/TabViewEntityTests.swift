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
    func test_whenMapToComponentIsCalled_thenItShouldReturnTabView() {
        // Given
        let buttonEntity = ButtonEntity(text: "button", style: "")
        let tabsEntity = TabItemEntity(icon: "", title: "Teste", content: AnyDecodableContainer(content: buttonEntity))
        let sut = TabViewEntity(tabItems: [tabsEntity], style: "")
        
        // When
        let tabView = try? sut.mapToComponent()
        
        // Then
        XCTAssertNotNil(tabView, "The TabBar component should not be nil.")
        XCTAssertTrue(tabView is TabView)
    }
    
    func test_whenGettingComponentFromJson_thenItShouldReturnTabView() {
        // Given /When
        guard let component: TabView = try? componentFromJsonFile(fileName: "TabView") else {
            XCTFail("Unable to get Tab View Component from json File.")
            return
        }

        // Then
        XCTAssertNotNil(component, "The TabBar component should not be nil.")
    }
}
