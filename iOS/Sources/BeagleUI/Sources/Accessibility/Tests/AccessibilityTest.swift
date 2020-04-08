/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */


import XCTest
@testable import BeagleUI

class AccessibilityTest: XCTestCase {
    
    private lazy var configurator: ViewConfiguratorProtocol = ViewConfigurator(view: testView)
    private lazy var testView = UIView()
    private let label = "test label"
    
    func testIfAttributesWereAplliedToNavigationItem() {
        //given
        let accessibility = Accessibility(accessibilityLabel: label, accessible: true)
        let navigationItem = UINavigationItem()

        //when
        ViewConfigurator.applyAccessibility(accessibility, to: navigationItem)

        //then
        XCTAssert(navigationItem.accessibilityLabel == label)
        XCTAssert(navigationItem.isAccessibilityElement)
    }

    func testIfAttributesWereAplliedToBarButtonItem() {
        //given
        let accessibility = Accessibility(accessibilityLabel: label, accessible: true)
        let barButtonItem = UIBarButtonItem()

        //when
        ViewConfigurator.applyAccessibility(accessibility, to: barButtonItem)

        //then
        XCTAssert(barButtonItem.accessibilityLabel == label)
        XCTAssert(barButtonItem.isAccessibilityElement)
    }
    
    func testIfAttributesWereAplliedToView() {
        //given
        let accessibility = Accessibility(accessibilityLabel: label, accessible: true)
        
        //when
        configurator.setup(accessibility: accessibility)
        
        //then
        XCTAssert(testView.accessibilityLabel == label)
        XCTAssert(testView.isAccessibilityElement)
    }
    
    func testIfViewIsNotAccessible() {
        //given
        let accessibility = Accessibility(accessible: false)
        
        //when
        configurator.setup(accessibility: accessibility)
        
        //then
        XCTAssert(testView.isAccessibilityElement == false)
    }
}
