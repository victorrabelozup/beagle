//
//  TabViewUIComponentTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 29/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class TabViewUIComponentTests: XCTestCase {
    
    // MARK: - Variables
    private lazy var widget = TabView(tabItems: [
        TabItem(icon: "beagle", title: "Tab 1") {
            FlexWidget {
                Text("Blaaslkdjfaskldjfalskdjfasldjfasldfj")
                Text("Blaaslkdjfaskldjfalskdjfasldjfasldfj")

            }.applyFlex(Flex(alignContent: .center))
        },
        TabItem(icon: "beagle", title: "Tab 2") {
            FlexWidget {
                Text("Text1 Tab 2")
                Text("Text2 Tab 2")
            }.applyFlex(Flex(justifyContent: .flexEnd))
        }
    ])
    
    private lazy var model = TabViewUIComponent.Model(tabIndex: 0, tabViewItems: widget.tabItems)

    private lazy var sut = TabViewUIComponent(model: model)

    private func makeScreen(_ widget: Widget) -> BeagleScreenViewController {
        BeagleScreenViewController(screenType: .declarative(widget))
    }

    // MARK: - Unit testing Functions
    func test_initShouldSetupCollectionView() {
        // Given / When
        guard let collectionView = sut.subviews.first(where: { $0 is UICollectionView }) as? UICollectionView else {
            XCTFail("Could not find `collectionView`.")
            return
        }
        XCTAssertNotNil(collectionView.collectionViewLayout, "Expected collectionViewLayout to be initiated.")
    }
    
    func test_numberOfItemsInSection_shouldReturnModelItemsCount() {
        // Given / When
        let mockedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        let count = sut.collectionView(mockedCollectionView, numberOfItemsInSection: 1)
        
        guard (sut.subviews.first(where: { $0 is UICollectionView }) as? UICollectionView) != nil else {
            XCTFail("Could not find `collectionView`.")
            return
        }
        
        // Then
        XCTAssertEqual(model.tabViewItems.count, count, "Expected \(model.tabViewItems.count), but got \(count).")
    }
    
    func test_cellForItemAt_shouldReturnCorrectCell() {
        // Given
        guard let collectionView = sut.subviews.first(where: { $0 is UICollectionView }) as? UICollectionView else {
            XCTFail("Could not retrieve `collectionView`.")
            return
        }
        let indexPath = IndexPath(item: 0, section: 0)
        
        // When
        let cell = sut.collectionView(collectionView, cellForItemAt: indexPath)
        
        // Then
        XCTAssertTrue(cell is TabBarCollectionViewCell, "The returned cell should be of type `TabBarCollectionViewCell`.")
        XCTAssertEqual(1, cell.contentView.subviews.count, "The cell's `contentView` should have a stackView.")
    }
    
    func test_didSelectItem_shouldChangeIndicatorViewColor() {
        // Given /When
        let mockedCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 360, height: 50), collectionViewLayout: UICollectionViewFlowLayout())
        
        sut.collectionView(mockedCollectionView, didSelectItemAt: IndexPath(row: 0, section: 1))
        
        guard (sut.subviews.first(where: { $0 is UICollectionView }) as? UICollectionView) != nil else {
            XCTFail("Could not find `collectionView`.")
            return
        }
    }
    
    func test_whenChangedPages_shouldCallChangeFunction() {
        // Given
        let pages: [BeagleScreenViewController] = [
            makeScreen(Text("Index: 1")),
            makeScreen(Text("Index: 2")),
            makeScreen(Text("Index: 3"))
        ]
        
        let pageView = PageViewUIComponent(
            model: .init(pages: pages),
            indicatorView: DefaultPageIndicatorUIComponent()
        )
        
        // When
        let spy = PageViewUIComponentSpyDelegate()
        pageView.pageViewDelegate = spy
        pageView.pageViewController(pageView.pageViewController, willTransitionTo: [pages[1]])
        pageView.pageViewController(
            pageView.pageViewController,
            didFinishAnimating: true,
            previousViewControllers: [],
            transitionCompleted: true
        )
        
        // Then
        XCTAssertTrue(spy.changedCurrentPageFuncionCalled, "Expected changedCurrentPageFunction to be called.")
    }
    
    func test_whenChangedPages_shouldChangeCollectionTab() {
        // Given / When
        sut.contentView.pageViewController(sut.contentView.pageViewController, willTransitionTo: [sut.contentView.model.pages[1]])
        sut.contentView.pageViewController(
            sut.contentView.pageViewController,
            didFinishAnimating: true,
            previousViewControllers: [],
            transitionCompleted: true
        )
        // Then
        XCTAssertEqual(sut.contentView.model.currentPage, sut.model.tabIndex, "Expected indexes to be the same.")
    }
    
    func test_whenChangedTabs_shouldChangeCurrentPage() {
        sut.collectionView(sut.collectionView, didSelectItemAt: IndexPath(item: 1, section: 0))
        XCTAssert(sut.contentView.model.currentPage == 1)
        sut.collectionView(sut.collectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
        XCTAssert(sut.contentView.model.currentPage == 0)
    }
}

private class PageViewUIComponentSpyDelegate: PageViewUIComponentDelegate {
    var changedCurrentPageFuncionCalled = false
    
    func changedCurrentPage(_ currentPage: Int) {
        changedCurrentPageFuncionCalled = true
    }
}
