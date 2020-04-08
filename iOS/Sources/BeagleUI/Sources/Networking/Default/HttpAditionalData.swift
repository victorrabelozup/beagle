/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import Foundation

/// You can pass this to a Remote Beagle Screen to pass additional http data on requests
/// triggered by Beagle.
public struct HttpAdditionalData: RemoteScreenAdditionalData {

    public let httpData: HttpData?
    public let headers: [String: String]

    public struct HttpData {
        public let method: Method
        public let body: Data

        public init(method: Method, body: Data) {
            self.method = method
            self.body = body
        }
    }

    public enum Method: String {
        case POST, PUT
    }

    public init(
        httpData: HttpData?,
        headers: [String: String] = [:]
    ) {
        self.httpData = httpData
        self.headers = headers
    }
}
