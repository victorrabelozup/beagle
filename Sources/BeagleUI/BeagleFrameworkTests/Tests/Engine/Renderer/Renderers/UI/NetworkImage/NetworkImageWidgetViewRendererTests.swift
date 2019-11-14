//
//  NetworkImageWidgetViewRendererTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 01/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
import Caching
import Networking
@testable import BeagleUI

final class NetworkImageWidgetViewRendererTests: XCTestCase {
    
    func test_onBuildingNetworkImageWidgetWithImageOnURL_shouldFetchImageCorrectly() {
        // Given
        let widget = NetworkImage(url: "https://cdn1-www.dogtime.com/assets/uploads/2011/01/file_23012_beagle-460x290.jpg")

        // When
        guard let networkImageWidgetRenderer = try? NetworkImageWidgetViewRenderer(widget) else {
            XCTFail("Could not create NetworkImageWidgetViewRenderer.")
            return
        }
                
        guard let _ = networkImageWidgetRenderer.buildView(context: BeagleContextDummy()) as? UIImageView else {
            XCTFail("Build view not returning UIImageView.")
            return
        }
    }
    
    func test_onBuildingNetworkImageWithAnInvalidURL_itShouldNotSetImage() {
        // Given
        let widget = NetworkImage(url: "www.com")
        
        // When
        guard let networkImageWidgetRenderer = try? NetworkImageWidgetViewRenderer(widget) else {
            XCTFail("Could not create NetworkImageWidgetViewRenderer.")
            return
        }
        
        guard let imageView = networkImageWidgetRenderer.buildView(context: BeagleContextDummy()) as? UIImageView else {
            XCTFail("Build view not returning UIImageView")
            return
        }
        
        // Then
        XCTAssertNil(imageView.image, "Expected image to be nil.")
    }
}
