//
//  Copyright © 18/12/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI
import SnapshotTesting

final class ListViewTests: XCTestCase {

    private let imageSize = CGSize(width: 300, height: 500)

    // MARK: - 3 Rows

    private let just3Rows: [ServerDrivenComponent] = [
        Text("Item 1"),
        Text("Item 2"),
        Text("Item 3")
    ]

    func testDirectionHorizontal() throws {
        let component = ListView(
            rows: just3Rows,
            direction: .horizontal
        )

        let view = makeListUiView(component)

        assertSnapshotImage(view, size: imageSize)
    }

    func testDirectionVertical() throws {
        let component = ListView(
            rows: just3Rows,
            direction: .vertical
        )

        let view = makeListUiView(component)

        assertSnapshotImage(view, size: imageSize)
    }

    // MARK: - Many Rows

    private let manyRows: [ServerDrivenComponent] = (0..<20).map { i in
        Text("Item \(i)")
    }

    func testDirectionHorizontalWithManyRows() {
        let component = ListView(
            rows: manyRows,
            direction: .horizontal
        )

        let view = makeListUiView(component)

        assertSnapshotImage(view, size: imageSize)
    }

    func testDirectionVerticalWithManyRows() {
        let component = ListView(
            rows: manyRows,
            direction: .vertical
        )

        let view = makeListUiView(component)

        assertSnapshotImage(view, size: imageSize)
    }

    // MARK: - Many Large Rows

    private let manyLargeRows: [ServerDrivenComponent] = (0..<20).map { i in
        Text("< \(i) \(String(repeating: "-", count: 22)) \(i) >")
    }

    func testDirectionHorizontalWithManyLargeRows() {
        let component = ListView(
            rows: manyLargeRows,
            direction: .horizontal
        )

        let view = makeListUiView(component)

        assertSnapshotImage(view, size: imageSize)
    }

    func testDirectionVerticalWithManyLargeRows() {
        let component = ListView(
            rows: manyLargeRows,
            direction: .vertical
        )

        let view = makeListUiView(component)

        assertSnapshotImage(view, size: imageSize)
    }

    // MARK: Rows with Different Sizes

    private let rowsWithDifferentSizes: [ServerDrivenComponent] = (0..<20).map { i in
        Text("< \(i) ---\(i % 3 == 0 ? "/ \n\n /" : "")--- \(i) >")
    }

    func testDirectionHorizontalWithRowsWithDifferentSizes() {
        let component = ListView(
            rows: rowsWithDifferentSizes,
            direction: .horizontal
        )

        let view = makeListUiView(component)

        assertSnapshotImage(view, size: imageSize)
    }

    func testDirectionVerticalWithRowsWithDifferentSizes() {
        let component = ListView(
            rows: rowsWithDifferentSizes,
            direction: .vertical
        )

        let view = makeListUiView(component)

        assertSnapshotImage(view, size: imageSize)
    }

    // MARK: - Cells

    func testCell_prepareForReuse_shouldCancelHTTPRequest_andRemoveComponentView() {
        // Given
        let componentWithRequestViewSpy = ComponentWithRequestViewSpy()
        componentWithRequestViewSpy.tag = 123
        let sut = ListItemCollectionViewCell()
        sut.setup(with: componentWithRequestViewSpy)

        // When
        sut.prepareForReuse()
        let innerComponentView = Mirror(reflecting: sut).children.first {
            $0.label == "componentView"
        }?.value as? UIView

        // Then
        XCTAssert(componentWithRequestViewSpy.cancelHTTPRequestCalled)
        XCTAssert(sut.contentView.subviews.isEmpty)
        XCTAssert(sut.contentView.viewWithTag(componentWithRequestViewSpy.tag) == nil)
        XCTAssert(innerComponentView == nil)
    }

    // MARK: - Helper

    private func makeListUiView(_ listComponent: ListView) -> UIView {
        return listComponent.toView(
            context: BeagleContextDummy(),
            dependencies: BeagleDependencies()
        )
    }

}

// MARK: - Testing Helpers

private class ComponentWithRequestViewSpy: UIView, HTTPRequestCanceling {

    private(set) var cancelHTTPRequestCalled = false
    
    func cancelHTTPRequest() {
        cancelHTTPRequestCalled = true
    }

}
