//
//  Copyright © 01/11/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class NetworkImageTests: XCTestCase {

    private let dependencies = RendererDependenciesContainer()
    
    func test_withInvalidURL_itShouldNotSetImage() throws {
        // Given
        let widget = NetworkImage(url: "www.com")
        
        // When
        guard let imageView = widget.toView(context: BeagleContextDummy(), dependencies: RendererDependenciesContainer()) as? UIImageView else {
            XCTFail("Build view not returning UIImageView")
            return
        }
        
        // Then
        XCTAssertNil(imageView.image, "Expected image to be nil.")
    }
}
