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

        assertSnapshot(matching: view, as: .image(size: imageSize))
    }

    func testDirectionVertical() throws {
        let widget = ListView(
            rows: just3Rows,
            direction: .vertical
        )

        let view = makeListUiView(widget)

        assertSnapshot(matching: view, as: .image(size: imageSize))
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

        assertSnapshot(matching: view, as: .image(size: imageSize))
    }

    func testDirectionVerticalWithManyRows() {
        let widget = ListView(
            rows: manyRows,
            direction: .vertical
        )

        let view = makeListUiView(widget)

        assertSnapshot(matching: view, as: .image(size: imageSize))
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

        assertSnapshot(matching: view, as: .image(size: imageSize))
    }

    func testDirectionVerticalWithManyLargeRows() {
        let widget = ListView(
            rows: manyLargeRows,
            direction: .vertical
        )

        let view = makeListUiView(widget)

        assertSnapshot(matching: view, as: .image(size: imageSize))
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

        assertSnapshot(matching: view, as: .image(size: imageSize))
    }

    func testDirectionVerticalWithRowsWithDifferentSizes() {
        let widget = ListView(
            rows: rowsWithDifferentSizes,
            direction: .vertical
        )

        let view = makeListUiView(widget)

        assertSnapshot(matching: view, as: .image(size: imageSize))
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
        let innerWidgetView = Mirror(reflecting: sut).children.first(where: { $0.label == "widgetView" } )?.value as? UIView

        // Then
        XCTAssertTrue(widgetWithRequestViewSpy.cancelHTTPRequestCalled, "`cancelHTTPRequest` should have been called.")
        XCTAssertEqual(sut.contentView.subviews.count, 0, "`contentView` should have no subviews.")
        XCTAssertNil(sut.contentView.viewWithTag(widgetWithRequestViewSpy.tag), "`contentView` should not contain the `widgetView`.")
        XCTAssertNil(innerWidgetView, "The inner property `widgetView` should be nil.")
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
