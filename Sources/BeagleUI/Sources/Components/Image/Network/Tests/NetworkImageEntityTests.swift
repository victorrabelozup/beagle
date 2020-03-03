//
//  Copyright © 15/10/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class NetworkImageEntityTests: XCTestCase {

    func test_whenMapToComponentIsCalled_thenItShouldReturnANetworkImage() {
        // Given
        let sut = NetworkImageEntity(
            path: "https://teste.com",
            contentMode: .center
        )
        
        // When
        let networkImage = try? sut.mapToComponent()
        
        // Then
        XCTAssert(networkImage != nil)
        XCTAssert(networkImage is NetworkImage)
    }
}
