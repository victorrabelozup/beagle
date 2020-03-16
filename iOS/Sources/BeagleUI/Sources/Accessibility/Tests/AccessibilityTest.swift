//
//  Copyright © 14/02/20 Zup IT. All rights reserved.
//

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
