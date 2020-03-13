//
//  Copyright © 09/03/20 Zup IT. All rights reserved.
//

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
