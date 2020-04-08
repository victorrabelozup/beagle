/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import Foundation

import XCTest
@testable import BeagleUI
import SnapshotTesting

final class UrlRequestBuilderTest: XCTestCase {

    let sut = HttpRequestBuilder()

    func testBuilder() {
        let builders = buildAllUrls()
        assertSnapshot(matching: builders, as: .dump)
    }

    // swiftlint:disable force_unwrapping
    private func buildAllUrls() -> [TestData] {
        let requests = createAllPossibleRequests()

        let httpData = HttpAdditionalData(
            httpData: .init(method: .POST, body: Data()),
            headers: ["header": "header"]
        )
        let datas = [nil, httpData]

        let url = URL(string: "scheme://baseUrl/")!

        var builders = [TestData]()
        var count = 0
        requests.forEach { request in
            datas.forEach { data in
                count += 1
                let result = sut.build(url: url, requestType: request, additionalData: data)

                builders.append(TestData(
                    testNumber: count,
                    parameters: .init(url: url, requestType: request, data: data),
                    result: result
                ))
            }
        }

        return builders
    }

    private func createAllPossibleRequests() -> [Request.RequestType] {
        let forms = createAllForms().map { Request.RequestType.submitForm($0) }

        var types: [Request.RequestType] = [
            .fetchComponent, .fetchImage
        ]

        types.append(contentsOf: forms)
        return types
    }

    private func createAllForms() -> [Request.FormData] {
        let methods = FormRemoteAction.Method.allCases
        let values = [["key": "value"], [:]]

        var forms = [Request.FormData]()
        methods.forEach { m in
            values.forEach { v in
                forms.append(.init(method: m, values: v))
            }
        }
        return forms
    }

    private struct TestData: AnySnapshotStringConvertible {

        static var renderChildren = true
        var snapshotDescription: String { return "" }

        let testNumber: Int
        let parameters: Parameters
        let result: HttpRequestBuilder.Result

        struct Parameters {
            let url: URL
            let requestType: Request.RequestType
            let data: RemoteScreenAdditionalData?
        }
    }
}

extension String: RemoteScreenAdditionalData { }
