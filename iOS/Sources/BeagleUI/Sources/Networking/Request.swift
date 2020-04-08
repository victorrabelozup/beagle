/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import Foundation

public struct Request {
    public let url: String
    public let type: RequestType
    public let additionalData: RemoteScreenAdditionalData?

    public init(
        url: String,
        type: RequestType,
        additionalData: RemoteScreenAdditionalData?
    ) {
        self.url = url
        self.type = type
        self.additionalData = additionalData
    }

    public enum RequestType {
        case fetchComponent
        case submitForm(FormData)
        case fetchImage
    }

    public struct FormData {
        public let method: FormRemoteAction.Method
        public let values: [String: String]

        public init(
            method: FormRemoteAction.Method,
            values: [String: String]
        ) {
            self.method = method
            self.values = values
        }
    }

    public enum Error: Swift.Error {
        case networkError(Swift.Error)
        case decoding(Swift.Error)
        case loadFromTextError
    }
}
