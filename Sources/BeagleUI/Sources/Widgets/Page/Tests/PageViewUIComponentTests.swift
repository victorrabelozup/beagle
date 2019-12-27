//
//  PageViewUIComponentTests.swift
//  BeagleUI
//
//  Created by Frederico Franco on 02/12/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

class PageViewUIComponentTests: XCTestCase {

    private lazy var pageView = PageViewUIComponent(
        model: .init(pages: pages),
        indicatorView: DefaultPageIndicatorUIComponent()
    )

    private lazy var pages: [BeagleScreenViewController] = [
        makeScreen(Text("Index: 1")),
        makeScreen(Text("Index: 2")),
        makeScreen(Text("Index: 3"))
    ]

    private func makeScreen(_ widget: Widget) -> BeagleScreenViewController {
        BeagleScreenViewController(
            viewModel: .init(screenType: .declarative(widget))
        )
    }

    private lazy var pager = pageView.pageViewController

    func test_whenChangingPagesFromUi_thenShouldUpdateModelOnlyWhenFinishedAnimationAndTransition() {
        pageView.pageViewController(pager, willTransitionTo: [pages[1]])
        pageView.pageViewController(
            pager,
            didFinishAnimating: true,
            previousViewControllers: [],
            transitionCompleted: true
        )
        XCTAssert(pageView.model.currentPage == 1)

        pageView.pageViewController(pager, willTransitionTo: [pages[2]])
        pageView.pageViewController(
            pager,
            didFinishAnimating: true,
            previousViewControllers: [],
            transitionCompleted: true
        )
        XCTAssert(pageView.model.currentPage == 2)
    }

    func test_whenChangingPagesFromUi_thenShouldReturnTheRightNextPage() {
        // Forward / After
        XCTAssert(pageView.pageViewController(pager, viewControllerAfter: pages[0]) === pages[1])
        XCTAssert(pageView.pageViewController(pager, viewControllerAfter: pages[1]) === pages[2])
        XCTAssert(pageView.pageViewController(pager, viewControllerAfter: pages[2]) === nil)

        // Backward / Before
        XCTAssert(pageView.pageViewController(pager, viewControllerBefore: pages[0]) === nil)
        XCTAssert(pageView.pageViewController(pager, viewControllerBefore: pages[1]) === pages[0])
        XCTAssert(pageView.pageViewController(pager, viewControllerBefore: pages[2]) === pages[1])
    }

    func test_whenCallingSwipePage_thenShouldUpdateModel() {
        for index in pages.indices {
            pageView.swipeToPage(at: index)
            XCTAssert(pageView.model.currentPage == index)
        }
    }

}
