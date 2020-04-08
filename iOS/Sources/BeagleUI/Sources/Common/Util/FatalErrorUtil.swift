/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import Foundation

/// This replaces the system's `fatalError` implementation, calling our util in order to make it
/// possible for us to capture it's parameters, results and such, then unit test our fatal errors 🎉
func fatalError(_ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) -> Never {
    FatalErrorUtil.fatalErrorClosure(message(), file, line)
}

/// Defines a Wrapper to enable exchanging the system's implementation for ours.
struct FatalErrorUtil {
    
    /// The closure that will call a system's `fatalError` implementation
    static var fatalErrorClosure: (String, StaticString, UInt) -> Never = defaultFatalErrorClosure
    
    /// The reference to the `fatalError` implementation provided by Swift
    private static let defaultFatalErrorClosure = { Swift.fatalError($0, file: $1, line: $2) }
    
    /// Static method to replace the `fatalError` implementation with a custom one.
    static func replaceFatalError(closure: @escaping (String, StaticString, UInt) -> Never) {
        fatalErrorClosure = closure
    }
    
    /// Restores the `fatalError` implementation with the default one.
    static func restoreFatalError() {
        fatalErrorClosure = defaultFatalErrorClosure
    }
    
}
