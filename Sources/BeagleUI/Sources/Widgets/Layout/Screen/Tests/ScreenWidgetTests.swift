//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ScreenWidgetTests: XCTestCase {

    func test_initWithBuilders_shouldReturnExpectedInstance() {
        // Given / When
        let widget = ScreenWidget(
            header: Text("text"),
            content: Text("text"),
            footer: Text("text")
        )

        // Then
        XCTAssert(widget.header is Text)
        XCTAssert(widget.content is Text)
        XCTAssert(widget.footer is Text)
    }

}
