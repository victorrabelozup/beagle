//
//  Copyright © 01/11/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class NetworkImageWidgetViewRendererTests: XCTestCase {

    private let dependencies = RendererDependenciesContainer()

    func test_withValidURL_itShouldFetchImage() throws {
        // Given
        let widget = NetworkImage(url: "https://cdn1-www.dogtime.com/assets/uploads/2011/01/file_23012_beagle-460x290.jpg")

        // When
        let renderer = try NetworkImageWidgetViewRenderer(widget: widget, dependencies: dependencies)
                
        guard let _ = renderer.buildView(context: BeagleContextDummy()) as? UIImageView else {
            XCTFail("Build view not returning UIImageView.")
            return
        }
    }
    
    func test_withInvalidURL_itShouldNotSetImage() throws {
        // Given
        let widget = NetworkImage(url: "www.com")
        
        // When
        let renderer = try NetworkImageWidgetViewRenderer(widget: widget, dependencies: dependencies)
        
        guard let imageView = renderer.buildView(context: BeagleContextDummy()) as? UIImageView else {
            XCTFail("Build view not returning UIImageView")
            return
        }
        
        // Then
        XCTAssertNil(imageView.image, "Expected image to be nil.")
    }
}
