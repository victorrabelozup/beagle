//
//  Copyright © 14/02/20 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

class AccessibilityTest: XCTestCase {

    private lazy var configurator: ViewConfiguratorProtocol = ViewConfigurator(view: testView)
    private lazy var testView = UIView()
    private let label = "test label"

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
