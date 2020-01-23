//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ScreenWidgetEntityTests: XCTestCase {

    func test_whenMapToWidgetIsCalled_thenItShouldReturnAContainerWidget() {
        // Given
        let innerContent = TextEntity(text: "text")
        let containerMock = AnyDecodableContainer(content: innerContent)
        let sut = ScreenWidgetEntity(
            safeArea: nil,
            navigationBar: nil,
            header: containerMock,
            content: containerMock,
            footer: containerMock
        )

        // When
        let widget = try? sut.mapToWidget()

        // Then
        XCTAssert(widget != nil)
        XCTAssert(widget is ScreenWidget)
    }
}
