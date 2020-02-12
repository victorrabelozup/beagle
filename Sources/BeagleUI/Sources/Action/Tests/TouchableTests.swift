//
//  Copyright © 04/11/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI
import SnapshotTesting

final class TouchableTests: XCTestCase {

    func testTouchableComponent() throws {
        // Given
        let content = TextEntity(text: "text")
        let child = AnyDecodableContainer(content: content)
        let action = AnyDecodableContainer(content: NavigateEntity(type: .addView, path: "", shouldPrefetch: true, screen: nil, data: nil))
        let sut = TouchableEntity(action: action, child: child)

        // When
        let touchable = try sut.mapToComponent()

        // Then
        assertSnapshot(matching: touchable, as: .dump)
    }
    
    func testTouchableComponentWithUnknownAction() throws {
        // Given
        let content = TextEntity(text: "text")
        let child = AnyDecodableContainer(content: content)
        let action = AnyDecodableContainer(content: UnknownActionEntity())
        let sut = TouchableEntity(action: action, child: child)

        // When
        let touchable = try sut.mapToComponent()

        // Then
        assertSnapshot(matching: touchable, as: .dump)
    }

    func testTouchableView() throws {
        let touchable = Touchable(action: Navigate.popView, child: Text("Touchable"))
        let view = touchable.toView(context: BeagleContextDummy(), dependencies: BeagleDependencies())

        assertSnapshotImage(view, size: CGSize(width: 100, height: 80))
    }

    func testAllEntityToAction() throws {
        let types = NavigationType.allCases
        let paths = ["path", nil]
        let datas = [ ["data": ""], nil]
        let shouldPrefetch = [true, false]
        var str = ""
        types.forEach { t in paths.forEach { p in datas.forEach { d in shouldPrefetch.forEach { s in
            str += mapEntityToActionDescription(type: t, path: p, data: d, shouldPrefetch: s)
        }}}}

        assertSnapshot(matching: str, as: .description)
    }

    private func mapEntityToActionDescription(
        type: NavigationType,
        path: String?,
        data: [String: String]?,
        shouldPrefetch: Bool
    ) -> String {
        let entity = NavigateEntity(type: type, path: path, shouldPrefetch: shouldPrefetch, screen: nil, data: data)
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

struct UnknownActionEntity: Decodable {}
