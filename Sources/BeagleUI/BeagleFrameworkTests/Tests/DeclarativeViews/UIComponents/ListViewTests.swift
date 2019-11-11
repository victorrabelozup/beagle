//
//  ListViewTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 02/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ListViewTests: XCTestCase {

    func test_initWithRowBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let widget = ListView {
            Text("text")
        }

        // Then
        XCTAssertEqual(widget.rows?.count, 1, "Expected `rows.count` to be `1`.")
        XCTAssertTrue(widget.rows?[safe: 0] is Text, "Expected to find `Text`.")
    }
    
    func test_initWithClosureSingleWidget_shouldReturnExpectedInstance() {
        // Given / When
        let widget = ListView.new {
            Text("text")
        }

        // Then
        XCTAssertEqual(widget.rows?.count, 1, "Expected `rows.count` to be `1`.")
        XCTAssertTrue(widget.rows?[safe: 0] is Text, "Expected to find `Text`.")
    }
    
    func test_initWithRowsBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let widget = ListView {
            Text("text")
            Button(text: "text")
        }

        // Then
        XCTAssertEqual(widget.rows?.count, 2, "Expected `rows.count` to be `2`.")
        XCTAssertTrue(widget.rows?[safe: 0] is Text, "Expected to find `Text`.")
        XCTAssertTrue(widget.rows?[safe: 1] is Button, "Expected to find `Button`.")
    }
    
    func test_initWithClosureMultipleWidget_shouldReturnExpectedInstance() {
        // Given / When
        let widget = ListView.new {
            [Text("text"), Button(text: "text")]
        }

        // Then
        XCTAssertEqual(widget.rows?.count, 2, "Expected `rows.count` to be `2`.")
        XCTAssertTrue(widget.rows?[safe: 0] is Text, "Expected to find `Text`.")
        XCTAssertTrue(widget.rows?[safe: 1] is Button, "Expected to find `Button`.")
    }
    
    func test_callingRemoteDataSource_shouldChangeItsValue() {
        // Given
        let widget = ListView {
            Text("text")
        }
        
        // When
        let updatedWidget = widget.remoteDataSource("someSource")
        
        // Then
        XCTAssertNotEqual(widget.remoteDataSource, updatedWidget.remoteDataSource, "Expected `dataSource` to be diferent from initial value.")
    }
    
    func test_callingLoadingState_shouldChangeItsValue() {
        // Given
        let widget = ListView {
            Text("text")
        }

        // When
        let updatedWidget = widget.loadingState {
            Text("something")
        }

        // Then
        XCTAssertNotNil(updatedWidget.loadingState, "`updatedWidget.loadingState` should not be nil.")
        XCTAssertTrue(updatedWidget.loadingState is Text, "Expected `Text`, but bot \(String(describing: updatedWidget.loadingState))")
    }
    
    func test_callingDirection_shouldChangeItsValue() {
        // Given
        let widget = ListView {
            Text("text")
        }

        // When
        let updatedWidget = widget.direction(.horizontal)

        // Then
        XCTAssertNotEqual(widget.direction, updatedWidget.direction, "Expected `direction` to be diferent from initial value.")
    }
    
    func test_initWithDynamic_shouldReturnExpectedInstance() {
        // Given / When
        let widgetsCount = 5
        let widget = ListView.dynamic(widgetsCount) {
            Text("text")
        }

        // Then
        XCTAssertEqual(widget.rows?.count, widgetsCount, "Expected `rows.count` to be `\(widgetsCount)`.")
        widget.rows?.forEach { widget in
            XCTAssertTrue(widget is Text, "Expected to find `Text`.")
        }
    }
    
    func test_toUIKit_shouldConvertDirectionProperly() {
        // Given
        let expectedConversions: [UICollectionView.ScrollDirection] = [.horizontal, .vertical]
        let directionsToConvert: [ListView.Direction] = [.horizontal, .vertical]
        
        // When
        let converted = directionsToConvert.map { $0.toUIKit() }
        
        // Then
        XCTAssertEqual(expectedConversions, converted, "Expected \(expectedConversions), but got \(converted).")
    }

}
