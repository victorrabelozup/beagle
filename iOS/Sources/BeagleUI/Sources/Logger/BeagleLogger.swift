/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import Foundation
import os.log

public protocol DependencyLogger {
    var logger: BeagleLoggerType { get }
}

public protocol BeagleLoggerType {
    func log(_ log: LogType)
}

public class BeagleLogger: BeagleLoggerType {

    public func log(_ log: LogType) {
        os_log("\nBeagleSDK: %@", log: osLog(for: log), type: toOsLog(log.level), log.message)
    }

    // MARK: Private

    private static var subsystem = Bundle.main.bundleIdentifier ?? "BeagleSDK"

    private func osLog(for type: LogType) -> OSLog {
        return OSLog(subsystem: BeagleLogger.subsystem, category: type.category)
    }

    private func toOsLog(_ level: LogLevel) -> OSLogType {
        switch level {
        case .error: return .error
        case .info: return .info
        }
    }
}
