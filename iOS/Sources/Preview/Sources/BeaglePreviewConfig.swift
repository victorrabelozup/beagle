/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import UIKit

private let defaultLivePreviewHost = "ws://localhost:9721"

public struct BeaglePreviewConfig {

    public var host: String

    public static func load(from fileName: String) throws -> BeaglePreviewConfig {
        return buildDefaultConfig()
    }

    public static func buildDefaultConfig() -> BeaglePreviewConfig {
        return BeaglePreviewConfig(
            host: defaultLivePreviewHost
        )
    }

    public init(host: String) {
        self.host = host
    }
}