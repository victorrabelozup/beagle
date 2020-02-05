//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ContainerEntityTests: XCTestCase {
    
    func test_whenMapToWidgetIsCalled_thenItShouldReturnAContainer() {
        // Given
        let content = TextEntity(text: "text")
        let children = [AnyDecodableContainer(content: content)]
        let flex = FlexEntity()
        let sut = ContainerEntity(children: children, flex: flex)
        
        // When
        let containerWidget = try? sut.mapToWidget()
        
        // Then
        XCTAssertNotNil(containerWidget, "Container widget should not be nil.")
        XCTAssertTrue(containerWidget is Container)
    }
}
