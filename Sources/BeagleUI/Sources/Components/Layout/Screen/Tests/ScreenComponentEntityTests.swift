//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ScreenComponentEntityTests: XCTestCase {

    func test_whenMapToComponentIsCalled_thenItShouldReturnAContainerComponent() {
        // Given
        let innerContent = TextEntity(text: "text")
        let containerMock = AnyDecodableContainer(content: innerContent)
        let sut = ScreenComponentEntity(
            identifier: nil,
            appearance: nil,
            safeArea: nil,
            navigationBar: nil,
            header: containerMock,
            content: containerMock,
            footer: containerMock
        )

        // When
        let component = try? sut.mapToComponent()

        // Then
        XCTAssert(component != nil)
        XCTAssert(component is ScreenComponent)
    }
}
