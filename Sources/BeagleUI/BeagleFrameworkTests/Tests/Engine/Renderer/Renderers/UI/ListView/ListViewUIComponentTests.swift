//
//  ListViewUIComponentTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 07/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ListViewUIComponentTests: XCTestCase {
    
    func test_initShouldSetupCollectionView() {
        // Given
        let direction: ListView.Direction = .vertical
        let expectedDirection = direction.toUIKit()
        let widget = ListView(
            rows: [
                Text("Item 1"),
                Text("Item 2")
            ],
            direction: direction
        )
        guard let widgetViews = widget.rows?.compactMap({
            try? TextWidgetViewRenderer(widget: $0).buildView()
        }) else {
            XCTFail("Could not create widget row views.")
            return
        }
        let model = ListViewUIComponent.Model(
            widget: widget,
            widgetViews: widgetViews
        )
        
        // When
        let sut = ListViewUIComponent(
            frame: .init(x: 0, y: 0, width: 100, height: 100),
            model: model
        )
        guard let collectionView = sut.subviews.first(where: { $0 is UICollectionView } ) as? UICollectionView,
        let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        else {
            XCTFail("Could not find `collectionView`.")
            return
        }
        
        // Then
        XCTAssertEqual(.white, sut.backgroundColor, "Expected \(UIColor.white), but got \(String(describing: sut.backgroundColor)).")
        XCTAssertEqual(expectedDirection, flowLayout.scrollDirection, "Expected \(expectedDirection), but got \(flowLayout.scrollDirection).")
    }
    
    func test_numberOfItemsInSection_shouldReturnModelItemsCount() {
        // Given
        let widget = ListView(
            rows: [
                Text("Item 1"),
                Text("Item 2")
            ],
            direction: .vertical
        )
        guard let widgetViews = widget.rows?.compactMap({
            try? TextWidgetViewRenderer(widget: $0).buildView()
        }) else {
            XCTFail("Could not create widget row views.")
            return
        }
        let model = ListViewUIComponent.Model(
            widget: widget,
            widgetViews: widgetViews
        )
        let sut = ListViewUIComponent(
            frame: .init(x: 0, y: 0, width: 100, height: 100),
            model: model
        )
        let mockedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        // When
        let count = sut.collectionView(mockedCollectionView, numberOfItemsInSection: 1)
        
        // Then
        XCTAssertEqual(model.widgetViews.count, count, "Expected \(model.widgetViews.count), but got \(count).")
    }
    
    func test_cellForItemAt_shouldReturnCorrectCell() {
        // Given
        let widget = ListView(
            rows: [Text("Item 1")],
            direction: .vertical
        )
        guard let widgetViews = widget.rows?.compactMap({
            try? TextWidgetViewRenderer(widget: $0).buildView()
        }) else {
            XCTFail("Could not create widget row views.")
            return
        }
        let model = ListViewUIComponent.Model(
            widget: widget,
            widgetViews: widgetViews
        )
        let sut = ListViewUIComponent(
            frame: .init(x: 0, y: 0, width: 100, height: 100),
            model: model
        )
        guard let innerCollectionView = sut.subviews.first(where: { $0 is UICollectionView }) as? UICollectionView else {
            XCTFail("Could not retrieve inner `collectioView`.")
            return
        }
        let indexPath = IndexPath(item: 0, section: 0)
        
        // When
        let cell = sut.collectionView(innerCollectionView, cellForItemAt: indexPath)
        
        // Then
        XCTAssertTrue(cell is ListItemCollectionViewCell, "The returned cell should be of type `ListItemCollectionViewCell`.")
        XCTAssertEqual(1, cell.contentView.subviews.count, "The cell's `contentView` should have `1` subview.")
    }
    
    func test_sizeForItemAt_shouldReturnCorrectCellSize() {
        // Given
        let widget = ListView(
            rows: [Text("Item 1")],
            direction: .vertical
        )
        guard let widgetViews = widget.rows?.compactMap({
            try? TextWidgetViewRenderer(widget: $0).buildView()
        }) else {
            XCTFail("Could not create widget row views.")
            return
        }
        widgetViews.first?.sizeToFit()
        let model = ListViewUIComponent.Model(
            widget: widget,
            widgetViews: widgetViews
        )
        let sut = ListViewUIComponent(
            frame: .init(x: 0, y: 0, width: 100, height: 100),
            model: model
        )
        guard let innerCollectionView = sut.subviews.first(where: { $0 is UICollectionView }) as? UICollectionView else {
            XCTFail("Could not retrieve inner `collectioView`.")
            return
        }
        let indexPath = IndexPath(item: 0, section: 0)
        
        // When
        let size = sut.collectionView(
            innerCollectionView,
            layout: innerCollectionView.collectionViewLayout,
            sizeForItemAt: indexPath
        )
        
        // Then
        guard let expectedSize = widgetViews.first?.frame.size else {
            XCTFail("Could not retrieve inner `expectedSize`.")
            return
        }
        XCTAssertEqual(expectedSize.height, size.height, accuracy: 0.001, "Expected \(String(describing: expectedSize.height)), but got \(size.height).")
        XCTAssertEqual(expectedSize.width, size.width, accuracy: 0.001, "Expected \(String(describing: expectedSize.width)), but got \(size.width).")
    }
    
}
