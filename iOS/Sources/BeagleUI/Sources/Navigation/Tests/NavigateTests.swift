/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import XCTest
@testable import BeagleUI
import SnapshotTesting

final class NavigateTests: XCTestCase {

    func testAllEntityToAction() throws {
        let types = NavigateEntity.NavigationType.allCases
        let paths = ["path", nil]
        let datas = [ ["data": ""], nil]
        let shouldPrefetch = [true, false]
        var str = ""

        // swiftlint:disable closure_end_indentation
        types.forEach { t in paths.forEach { p in datas.forEach { d in shouldPrefetch.forEach { s in
            str += mapEntityToActionDescription(type: t, path: p, data: d, shouldPrefetch: s)
        }}}}

        assertSnapshot(matching: str, as: .description)
    }

    private func mapEntityToActionDescription(
        type: NavigateEntity.NavigationType,
        path: String?,
        data: [String: String]?,
        shouldPrefetch: Bool
    ) -> String {
        let entity = NavigateEntity(type: type, path: path, shouldPrefetch: shouldPrefetch, screen: nil, data: data)
        let pathDescription = path == nil ? "noPath" : "withPath"
        let dataDescription = data == nil ? "noData" : "withData"

        let actionDescription: String
        do {
            let action = try entity.mapToUIModel()
            actionDescription = "\(action)"
        } catch {
            actionDescription = "ERROR"
        }

        return """
        \(type)-\(pathDescription)-\(dataDescription) ->
        \(actionDescription)
        
        
        """
    }

}
