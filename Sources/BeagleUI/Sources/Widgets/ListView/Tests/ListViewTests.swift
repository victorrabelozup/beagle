//
//  Copyright © 18/12/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI
import SnapshotTesting

final class ListViewTests: XCTestCase {

    private let imageSize = CGSize(width: 300, height: 500)

    // MARK: - 3 Rows

    private let just3Rows: [Widget] = [
        Text("Item 1"),
        Text("Item 2"),
        Text("Item 3")
    ]

    func testDirectionHorizontal() throws {
        let widget = ListView(
            rows: just3Rows,
            direction: .horizontal
        )

        let view = makeListUiView(widget)

        assertSnapshotImage(view, size: imageSize)
    }

    func testDirectionVertical() throws {
        let widget = ListView(
            rows: just3Rows,
            direction: .vertical
        )

        let view = makeListUiView(widget)

        assertSnapshotImage(view, size: imageSize)
    }

    // MARK: - Many Rows

    private let manyRows: [Widget] = (0..<20).map { i in
        Text("Item \(i)")
    }

    func testDirectionHorizontalWithManyRows() {
        let widget = ListView(
            rows: manyRows,
            direction: .horizontal
        )

        let view = makeListUiView(widget)

        assertSnapshotImage(view, size: imageSize)
    }

    func testDirectionVerticalWithManyRows() {
        let widget = ListView(
            rows: manyRows,
            direction: .vertical
        )

        let view = makeListUiView(widget)

        assertSnapshotImage(view, size: imageSize)
    }

    // MARK: - Many Large Rows

    private let manyLargeRows: [Widget] = (0..<20).map { i in
        Text("< \(i) \(String(repeating: "-", count: 22)) \(i) >")
    }

    func testDirectionHorizontalWithManyLargeRows() {
        let widget = ListView(
            rows: manyLargeRows,
            direction: .horizontal
        )

        let view = makeListUiView(widget)

        assertSnapshotImage(view, size: imageSize)
    }

    func testDirectionVerticalWithManyLargeRows() {
        let widget = ListView(
            rows: manyLargeRows,
            direction: .vertical
        )

        let view = makeListUiView(widget)

        assertSnapshotImage(view, size: imageSize)
    }

    // MARK: Rows with Different Sizes

    private let rowsWithDifferentSizes: [Widget] = (0..<20).map { i in
        Text("< \(i) ---\(i % 3 == 0 ? "/ \n\n /" : "")--- \(i) >")
    }

    func testDirectionHorizontalWithRowsWithDifferentSizes() {
        let widget = ListView(
            rows: rowsWithDifferentSizes,
            direction: .horizontal
        )

        let view = makeListUiView(widget)

        assertSnapshotImage(view, size: imageSize)
    }

    func testDirectionVerticalWithRowsWithDifferentSizes() {
        let widget = ListView(
            rows: rowsWithDifferentSizes,
            direction: .vertical
        )

        let view = makeListUiView(widget)

        assertSnapshotImage(view, size: imageSize)
    }

    // MARK: - Cells

    func testCell_prepareForReuse_shouldCancelHTTPRequest_andRemoveWidgetView() {
        // Given
        let widgetWithRequestViewSpy = WidgetWithRequestViewSpy()
        widgetWithRequestViewSpy.tag = 123
        let sut = ListItemCollectionViewCell()
        sut.setup(with: widgetWithRequestViewSpy)

        // When
        sut.prepareForReuse()
        let innerWidgetView = Mirror(reflecting: sut).children.first {
            $0.label == "widgetView"
        }?.value as? UIView

        // Then
        XCTAssert(widgetWithRequestViewSpy.cancelHTTPRequestCalled)
        XCTAssert(sut.contentView.subviews.isEmpty)
        XCTAssert(sut.contentView.viewWithTag(widgetWithRequestViewSpy.tag) == nil)
        XCTAssert(innerWidgetView == nil)
    }

    // MARK: - Helper

    private func makeListUiView(_ listWidget: ListView) -> UIView {
        return listWidget.toView(
            context: BeagleContextDummy(),
            dependencies: BeagleDependencies(appName: "Test")
        )
    }

}

// MARK: - Testing Helpers

private class WidgetWithRequestViewSpy: UIView, HTTPRequestCanceling {

    private(set) var cancelHTTPRequestCalled = false
    
    func cancelHTTPRequest() {
        cancelHTTPRequestCalled = true
    }

}
