//
//  Copyright © 05/02/20 Zup IT. All rights reserved.
//

import Foundation

public struct Request {
    public let url: String
    public let type: RequestType

    public init(
        url: String,
        type: RequestType
    ) {
        self.url = url
        self.type = type
    }

    public enum RequestType {
        case fetchComponent
        case submitForm(FormData)
        case fetchImage
    }

    public struct FormData {
        let method: Form.MethodType
        let values: [String: String]

        public init(
            method: Form.MethodType,
            values: [String: String]
        ) {
            self.method = method
            self.values = values
        }
    }

    public enum Error: Swift.Error {
        case networkError(Swift.Error)
        case decoding(Swift.Error)
    }
}
