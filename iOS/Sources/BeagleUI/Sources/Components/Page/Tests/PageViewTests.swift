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

class PageViewTests: XCTestCase {

    func test_whenDecodingJson_thenItShouldReturnAPageView() throws {
        let component: PageView = try componentFromJsonFile(fileName: "PageViewWith3Pages")
        assertSnapshot(matching: component, as: .dump)
    }

    func test_whenDecodingJson_thenItShouldReturnPageViewWithIndicator() throws {
        let component: PageView = try componentFromJsonFile(fileName: "PageViewWith3PagesAndIndicator")
        assertSnapshot(matching: component, as: .dump)
    }

    func test_whenDecodingInvalidJson() throws {
        XCTAssertThrowsError(
            try componentFromJsonFile(componentType: PageView.self, fileName: "PageViewInvalid")
        )
    }

    private let page = Container(children: [
        Text("First text"),
        Button(text: "Button"),
        Text("Second text")
    ]).applyFlex(Flex(flexDirection: .column, justifyContent: .center))

    func test_viewWithPages() {
        let pageView = PageView(
            pages: Array(repeating: page, count: 5),
            pageIndicator: nil
        )

        let screen = Beagle.screen(.declarative(pageView.toScreen()))
        assertSnapshotImage(screen)
    }

    func test_viewWithPagesAndIndicator() {
        let pageView = PageView(
            pages: Array(repeating: page, count: 5),
            pageIndicator: PageIndicator(selectedColor: "#d1cebd", unselectedColor: "#f6eedf")
        )

        let screen = Beagle.screen(.declarative(pageView.toScreen()))
        assertSnapshotImage(screen)
    }

}
