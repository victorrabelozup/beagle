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
        let component = listWithOneRow
        // Then
        XCTAssert(component.rows?.count == 1)
        XCTAssert(component.rows?[safe: 0] is Text)
    }
    
    func test_initWithRowsBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let component = ListView(rows: [
            Text("text"),
            Button(text: "text")
        ])

        // Then
        XCTAssert(component.rows?.count == 2)
        XCTAssert(component.rows?[safe: 0] is Text)
        XCTAssert(component.rows?[safe: 1] is Button)
    }
    
    func test_callingRemoteDataSource_shouldChangeItsValue() {
        // Given
        let component = listWithOneRow
        
        // When
        let updatedComponent = listWithOneRow.remoteDataSource("someSource")
        
        // Then
        XCTAssert(component.remoteDataSource != updatedComponent.remoteDataSource)
    }
    
    func test_callingLoadingState_shouldChangeItsValue() {
        // Given
        let component = listWithOneRow

        // When
        let updatedComponent = component.loadingState {
            Text("something")
        }

        // Then
        XCTAssertNotNil(updatedComponent.loadingState)
        XCTAssertTrue(updatedComponent.loadingState is Text)
    }
    
    func test_callingDirection_shouldChangeItsValue() {
        // Given
        let component = listWithOneRow

        // When
        let updatedComponent = component.direction(.horizontal)

        // Then
        XCTAssert(component.direction != updatedComponent.direction)
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
