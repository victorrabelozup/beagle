//
//  Copyright © 29/11/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class TabViewUIComponentTests: XCTestCase {
    
    // MARK: - Variables
    private lazy var widget = TabView(tabItems: [
        TabItem(icon: "beagle", title: "Tab 1", content:
            FlexWidget(children: [
                Text("Blaaslkdjfaskldjfalskdjfasldjfasldfj"),
                Text("Blaaslkdjfaskldjfalskdjfasldjfasldfj")
            ])
            .applyFlex(Flex(alignContent: .center))
        ),
        TabItem(icon: "beagle", title: "Tab 2", content:
            FlexWidget(children: [
                Text("Text1 Tab 2"),
                Text("Text2 Tab 2")
            ])
            .applyFlex(Flex(justifyContent: .flexEnd))
        )
    ])
    
    private lazy var model = TabViewUIComponent.Model(tabIndex: 0, tabViewItems: widget.tabItems)

    private lazy var sut = TabViewUIComponent(model: model)

    private func makeScreen(_ widget: Widget) -> BeagleScreenViewController {
        return BeagleScreenViewController(
            viewModel: .init(screenType: .declarative(widget.toScreen()))
        )
    }

    // MARK: - Unit testing Functions
    func test_initShouldSetupCollectionView() {
        // Given / When
        guard let collectionView = sut.subviews.first(where: { $0 is UICollectionView }) as? UICollectionView else {
            XCTFail("Could not find `collectionView`.")
            return
        }
        XCTAssertNotNil(collectionView.collectionViewLayout)
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
        XCTAssert(model.tabViewItems.count == count)
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
        XCTAssert(cell is TabBarCollectionViewCell)
        XCTAssert(cell.contentView.subviews.count == 1)
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
        XCTAssert(spy.changedCurrentPageFuncionCalled)
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
        XCTAssert(sut.contentView.model.currentPage == sut.model.tabIndex)
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
