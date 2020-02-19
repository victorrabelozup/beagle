//
//  Copyright © 14/02/20 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

class AccessibilityTest: XCTestCase {

    let configurator: AccessibilityConfiguratorProtocol = AccessibilityConfigurator()

    func testIfAttributesWereAplliedToView() {
        //given
        let accessibility = Accessibility(accessibilityLabel: "test label", accessible: true)
        let testView = UIView()
        
        //when
        configurator.applyAccessibilityAttributes(accessibility, to: testView)
        
        //then
        XCTAssertEqual(testView.accessibilityLabel, "test label")
        XCTAssertEqual(testView.isAccessibilityElement, true)
    }
    
    func testIfViewIsNotAccessible() {
        //given
        let accessibility = Accessibility(accessible: false)
        let testView = UIView()
        
        //when
        configurator.applyAccessibilityAttributes(accessibility, to: testView)
        
        //then
        XCTAssertEqual(testView.isAccessibilityElement, false)
    }
    
    func testIfMapToModelWereSuccessful() {
        //given
        let entity = AccessibilityEntity(accessibilityLabel: "test label", accessible: true)
        
        //when
        let accessibility = try? entity.mapToUIModel()
        
        //then
        XCTAssertNotNil(accessibility)
        XCTAssertEqual(accessibility?.accessibilityLabel, "test label")
        XCTAssertEqual(accessibility?.accessible, true)
    }
}
