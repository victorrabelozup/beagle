/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */


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
