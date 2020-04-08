/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */


import XCTest
@testable import BeagleUI

extension XCTestCase {
    
    /// Defines a way to create a `fatalError` expectation.
    /// - Parameter expectedMessage: The message to be shown when the expectation fails.
    /// - Parameter timeout: The expectation timeout.
    /// - Parameter testcase: The block of code that can throw a fatal error.
    func expectFatalError(
        expectedMessage: String,
        timeout: TimeInterval = 2.0,
        testcase: @escaping () -> Void
    ) {
        
        let expectation = self.expectation(description: "expectingFatalError")
        var assertionMessage: String?
        FatalErrorUtil.replaceFatalError { message, _, _ in
            assertionMessage = message
            expectation.fulfill()
            self.unreachable()
        }
        
        DispatchQueue.global(qos: .userInitiated).async(execute: testcase)
        
        waitForExpectations(timeout: timeout) { _ in
            XCTAssertEqual(assertionMessage, expectedMessage)
            FatalErrorUtil.restoreFatalError()
        }
        
    }
    
    private func unreachable() -> Never {
        repeat {
            RunLoop.current.run()
        } while (true)
    }
    
}
