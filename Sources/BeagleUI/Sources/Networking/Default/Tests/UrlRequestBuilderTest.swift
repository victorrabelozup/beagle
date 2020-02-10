//
//  Copyright © 05/02/20 Zup IT. All rights reserved.
//

import Foundation

import XCTest
@testable import BeagleUI
import SnapshotTesting

final class UrlRequestBuilderTest: XCTestCase {

    let sut = UrlRequestBuilder()

    func testBuilder() {
        let builders = buildAllUrls()
        assertSnapshot(matching: builders, as: .dump)
    }

    // swiftlint:disable force_unwrapping
    private func buildAllUrls() -> [TestData] {
        let requests = createAllRequests()
        let baseUrls = [URL(string: "baseUrl/")!, nil]

        var builders = [TestData]()
        var count = 0
        requests.forEach { request in
            baseUrls.forEach { baseUrl in
                count += 1

                let result = sut.buildUrlRequest(request: request, baseUrl: baseUrl)
                let str = """
                  \(descriptionWithoutOptional(baseUrl))  +  \(request)
                """
                builders += [TestData(testNumber: count, parameters: str, result: result)]
            }
        }

        return builders
    }

    private func createAllRequests() -> [Request] {
        let paths = ["path", ""]
        let forms = createAllForms().map { Request.RequestType.submitForm($0) }

        var types: [Request.RequestType] = [
            .fetchWidget, .fetchImage
        ]
        types.append(contentsOf: forms)

        var requests = [Request]()
        paths.forEach { p in
            types.forEach { t in
                requests.append(Request(url: p, type: t))
            }
        }

        return requests
    }

    private func createAllForms() -> [Request.FormData] {
        let methods = Form.MethodType.allCases
        let values = [["key": "value"], [:]]

        var forms = [Request.FormData]()
        methods.forEach { m in
            values.forEach { v in
                forms.append(.init(method: m, values: v))
            }
        }
        return forms
    }
}

private struct TestData: AnySnapshotStringConvertible {

    static var renderChildren = true

    private let testNumber: Int

    var snapshotDescription: String {
        return ""
    }

    let parameters: String
    let result: Result<URLRequest, NetworkClientDefault.ClientError>

    init(
        testNumber: Int,
        parameters: String,
        result: Result<URLRequest, NetworkClientDefault.ClientError>
    ) {
        self.testNumber = testNumber
        self.parameters = parameters
        self.result = result
    }
}
