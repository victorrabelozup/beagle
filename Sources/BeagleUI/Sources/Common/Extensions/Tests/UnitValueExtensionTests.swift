//
//  Copyright © 09/03/20 Zup IT. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import BeagleUI

final class UnitValueExtensionTests: XCTestCase {
    
    func test_UnitValueExpressibleByIntegerLiteral() {
        let sut: UnitValue = 10
        assertSnapshot(matching: sut, as: .dump)
    }
    
    func test_UnitValueExpressibleByFloatLiteral() {
        let sut: UnitValue = 10.5
        assertSnapshot(matching: sut, as: .dump)
    }
    
    func test_UnitValueWithPercentageOperatorAndIntegerValue() {
        let sut: UnitValue = 10%
        assertSnapshot(matching: sut, as: .dump)
    }
    
    func test_UnitValueWithPercentageOperatorAndFloatValue() {
        let sut: UnitValue = 10.5%
        assertSnapshot(matching: sut, as: .dump)
    }
}

