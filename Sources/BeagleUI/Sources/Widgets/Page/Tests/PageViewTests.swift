//
//  PageViewTests.swift
//  BeagleFrameworkTests
//
//  Created by Frederico Franco on 22/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI
import SnapshotTesting
import YogaKit

class PageViewTests: XCTestCase {

    func test_whenDecodingValidJson_thenItShouldReturnAPageView() throws {
        let widget: PageView = try widgetFromJsonFile(fileName: "PageViewWith3Pages")
        assertSnapshot(matching: widget, as: .dump)
    }

    func test_whenDecodingInvalidJson() throws {
        XCTAssertThrowsError(
            try widgetFromJsonFile(widgetType: PageView.self, fileName: "PageViewInvalid")
        )
    }

    func test_viewWith3SimplePages() {
        let page = FlexWidget {
            Text("First text")
            Button(text: "Button")
            Text("Second text")
        }.applyFlex(Flex(flexDirection: .column, justifyContent: .center))

        let pageView = PageView(
            pages: Array(repeating: page, count: 5),
            pageIndicator: nil
        )

        let screen = BeagleScreenViewController(screenType: .declarative(pageView))
        assertSnapshot(matching: screen, as: .image)
    }

}
