//
//  Copyright © 02/03/20 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class IdentifierTests: XCTestCase {
    
    func testApplyAccessibilityIdentifier() {
        //Given
        let view = UIView()
        let id = "identifier"
        
        //When
        view.applyAccessibilityIdentifier(id)
        
        //Then
        XCTAssert(view.accessibilityIdentifier == id)
    }
}
