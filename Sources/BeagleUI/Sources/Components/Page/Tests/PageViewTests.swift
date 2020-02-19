//
//  Copyright © 22/11/19 Zup IT. All rights reserved.
//

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
