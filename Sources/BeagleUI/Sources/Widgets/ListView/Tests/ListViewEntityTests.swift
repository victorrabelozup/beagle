//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ListViewEntityTests: XCTestCase {
    
    func test_whenMapToWidgetIsCalledOnVerticalListViewEntity_thenItShouldReturnAVerticalListView() {
        // Given
        let textEntity = TextEntity(text: "text")
        let rows = [AnyDecodableContainer(content: textEntity)]
        let sut = ListViewEntity(rows: rows, remoteDataSource: nil, loadingState: nil)
        
        // When
        let listView = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(listView, "The ListView widget should not be nil.")
        XCTAssertTrue(listView is ListView)
    }
    
}
