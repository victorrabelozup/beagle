//
//  Copyright © 04/11/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI
import SnapshotTesting

final class NavigatorTests: XCTestCase {

    func testNavigatorWidget() throws {
        // Given
        let action = NavigateEntity(type: .addView, path: "", data: nil)
        let content = TextEntity(text: "text")
        let child = AnyDecodableContainer(content: content)
        let sut = NavigatorEntity(action: action, child: child)

        // When
        let navigator = try sut.mapToWidget()

        // Then
        assertSnapshot(matching: navigator, as: .dump)
    }

    func testNavigatorView() throws {
        let navigator = Navigator(action: .popView, child: Text("Navigator"))
        let view = navigator.toView(context: BeagleContextDummy(), dependencies: BeagleDependencies())

        assertSnapshotImage(view, size: CGSize(width: 100, height: 80))
    }

    func testAllEntityToAction() throws {
        let types = NavigationType.allCases
        let paths = ["path", nil]
        let datas = [ ["data": ""], nil]

        var str = ""
        types.forEach { t in paths.forEach { p in datas.forEach { d in
            str += mapEntityToActionDescription(type: t, path: p, data: d)
        }}}

        assertSnapshot(matching: str, as: .description)
    }

    private func mapEntityToActionDescription(
        type: NavigationType,
        path: String?,
        data: [String: String]?
    ) -> String {
        let entity = NavigateEntity(type: type, path: path, data: data)
        let pathDescription = path == nil ? "noPath" : "withPath"
        let dataDescription = data == nil ? "noData" : "withData"

        let actionDescription: String
        do {
            let action = try entity.mapToAction()
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
