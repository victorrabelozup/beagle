//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ListViewEntityTests: XCTestCase {
    
    func test_whenMapToComponentIsCalledOnVerticalListViewEntity_thenItShouldReturnAVerticalListView() {
        // Given
        let textEntity = TextEntity(text: "text")
        let rows = [AnyDecodableContainer(content: textEntity)]
        let sut = ListViewEntity(rows: rows, direction: .vertical)
        
        // When
        let listView = try? sut.mapToComponent()
        
        // Then
        XCTAssertNotNil(listView, "The ListView component should not be nil.")
        XCTAssertTrue(listView is ListView)
    }
    
}
