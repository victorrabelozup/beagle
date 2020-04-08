/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import XCTest
@testable import BeagleUI

// swiftlint:disable force_unwrapping

final class MemoryCacheServiceTests: XCTestCase {

    // MARK: - Properties

    var sut = MemoryCacheService()

    // MARK: - Test Lifecycle

    override func tearDown() {
        super.tearDown()
        sut.clear()
    }

    // MARK: - Tests

    func testSaveAndLoad() {
        // Given
        let dataToSave = "value".data(using: .utf8)!
        let key = "Save-Memory-Tests"

        // When
        sut.save(data: dataToSave, key: key)
        let result = sut.loadData(from: key)

        // Then
        switch result {
        case .success(let data):
            XCTAssert(data == dataToSave)
        case .failure:
            XCTFail("should be able to load data")
        }
    }

    func testLoadingInvalidData() {
        // Given
        let key = "LoadFail-Memory-Tests"

        // When
        let result = sut.loadData(from: key)

        // Then
        switch result {
        case .success:
            XCTFail("should NOT be able to load unknown data")
        case .failure:
            XCTAssert(true)
        }
    }

    func testClear() {
        // Given
        let dataToSave = "value".data(using: .utf8)!
        let key = "Clear-Memory-Tests"
        sut.save(data: dataToSave, key: key)

        // When
        sut.clear()
        let result = sut.loadData(from: key)

        // Then
        switch result {
        case .success:
            XCTFail("should NOT be able to load cleared data")
        case .failure:
            XCTAssert(true)
        }
    }

}
