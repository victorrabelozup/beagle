//
//  Copyright © 02/10/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ListViewInitTests: XCTestCase {

    private let listWithOneRow = ListView(rows: [
        Text("text")
    ])

    func test_initWithRowBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let widget = listWithOneRow
        // Then
        XCTAssert(widget.rows?.count == 1)
        XCTAssert(widget.rows?[safe: 0] is Text)
    }
    
    func test_initWithRowsBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let widget = ListView(rows: [
            Text("text"),
            Button(text: "text")
        ])

        // Then
        XCTAssert(widget.rows?.count == 2)
        XCTAssert(widget.rows?[safe: 0] is Text)
        XCTAssert(widget.rows?[safe: 1] is Button)
    }
    
    func test_callingRemoteDataSource_shouldChangeItsValue() {
        // Given
        let widget = listWithOneRow
        
        // When
        let updatedWidget = listWithOneRow.remoteDataSource("someSource")
        
        // Then
        XCTAssert(widget.remoteDataSource != updatedWidget.remoteDataSource)
    }
    
    func test_callingLoadingState_shouldChangeItsValue() {
        // Given
        let widget = listWithOneRow

        // When
        let updatedWidget = widget.loadingState {
            Text("something")
        }

        // Then
        XCTAssertNotNil(updatedWidget.loadingState)
        XCTAssertTrue(updatedWidget.loadingState is Text)
    }
    
    func test_callingDirection_shouldChangeItsValue() {
        // Given
        let widget = listWithOneRow

        // When
        let updatedWidget = widget.direction(.horizontal)

        // Then
        XCTAssert(widget.direction != updatedWidget.direction)
    }
    
    func test_toUIKit_shouldConvertDirectionProperly() {
        // Given
        let expectedConversions: [UICollectionView.ScrollDirection] = [.horizontal, .vertical]
        let directionsToConvert: [ListView.Direction] = [.horizontal, .vertical]
        
        // When
        let converted = directionsToConvert.map { $0.toUIKit() }
        
        // Then
        XCTAssert(expectedConversions == converted)
    }

}
