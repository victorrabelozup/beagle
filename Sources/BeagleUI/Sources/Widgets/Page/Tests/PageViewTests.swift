//
//  Copyright © 22/11/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI
import SnapshotTesting
import YogaKit

class PageViewTests: XCTestCase {

    func test_whenDecodingJson_thenItShouldReturnAPageView() throws {
        let widget: PageView = try widgetFromJsonFile(fileName: "PageViewWith3Pages")
        assertSnapshot(matching: widget, as: .dump)
    }

    func test_whenDecodingJson_thenItShouldReturnPageViewWithIndicator() throws {
        let widget: PageView = try widgetFromJsonFile(fileName: "PageViewWith3PagesAndIndicator")
        assertSnapshot(matching: widget, as: .dump)
    }

    func test_whenDecodingInvalidJson() throws {
        XCTAssertThrowsError(
            try widgetFromJsonFile(widgetType: PageView.self, fileName: "PageViewInvalid")
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

        let screen = BeagleScreenViewController(
            viewModel: .init(screenType: .declarative(pageView.toScreen()))
        )
        assertSnapshotImage(screen)
    }

    func test_viewWithPagesAndIndicator() {
        let pageView = PageView(
            pages: Array(repeating: page, count: 5),
            pageIndicator: DefaultPageIndicator()
        )

        let screen = BeagleScreenViewController(
            viewModel: .init(screenType: .declarative(pageView.toScreen()))
        )
        assertSnapshotImage(screen)
    }

}
