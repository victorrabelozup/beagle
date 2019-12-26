//
//  Copyright © 18/12/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class BeaglePrefetchHelperTests: XCTestCase {
    
    func testPreFetchWidgetShouldAddScreenToTheMap() {
        // Given
        let sut = BeaglePreFetchHelper()
        let url = "www.something.com"
        
        // When
        sut.prefetchWidget(path: url)
        
        // Then
        XCTAssertNotNil(sut.dequeueWidget(path: url))
    }
    
    func testDequeueWidgetShouldReturnANewScreenWhenItsNotInTheMap() {
        // Given
        let sut = BeaglePreFetchHelper()
        
        // When
        let url = "www.something.com"
        
        // Then
        XCTAssertNotNil(sut.dequeueWidget(path: url))
    }

    func testPrefetchAndDequeue() {
        let sut = BeaglePreFetchHelper()
        let url = "url-test"

        sut.prefetchWidget(path: url)
        let result = sut.dequeueWidget(path: url)

        switch result.screenType {
        case .remote(let path):
            XCTAssert(path == url)
        case .declarative:
            XCTFail("Not the right type")
        }
    }
    
    func testPrefetchTheSameScreenTwice() {
        let sut = BeaglePreFetchHelper()
        let url = "url-test"

        sut.prefetchWidget(path: url)
        let result1 = sut.dequeueWidget(path: url)
        sut.prefetchWidget(path: url)
        let result2 = sut.dequeueWidget(path: url)
        
        XCTAssertTrue(result1 === result2, "`dequeueWidget` expected to return the same screen")
    }

}
