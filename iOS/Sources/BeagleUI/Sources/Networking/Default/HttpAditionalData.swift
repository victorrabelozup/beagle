//
//  Copyright © 05/03/20 Zup IT. All rights reserved.
//

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
