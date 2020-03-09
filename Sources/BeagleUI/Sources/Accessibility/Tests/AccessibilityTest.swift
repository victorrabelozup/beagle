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
    
    func testIfMapToModelWereSuccessful() {
        //given
        let entity = AccessibilityEntity(accessibilityLabel: label, accessible: true)
        
        //when
        let accessibility = try? entity.mapToUIModel()
        
        //then
        XCTAssert(accessibility != nil)
        XCTAssert(accessibility?.accessibilityLabel == label)
        XCTAssert(accessibility?.accessible == true)
    }

    func testApplyAccessibilityIdentifier() {
        //Given
        let id = "identifier"

        //When
        configurator.setup(id: id)

        //Then
        XCTAssert(testView.accessibilityIdentifier == id)
    }
}
