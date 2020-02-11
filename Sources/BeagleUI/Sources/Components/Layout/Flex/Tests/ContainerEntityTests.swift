//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ContainerEntityTests: XCTestCase {
    
    func test_whenMapToComponentIsCalled_thenItShouldReturnAContainer() {
        // Given
        let content = TextEntity(text: "text")
        let children = [AnyDecodableContainer(content: content)]
        let flex = FlexEntity()
        let sut = ContainerEntity(children: children, flex: flex)
        
        // When
        let containerComponent = try? sut.mapToComponent()
        
        // Then
        XCTAssertNotNil(containerComponent, "Container component should not be nil.")
        XCTAssertTrue(containerComponent is Container)
    }
}
