//
//  BeagleViewBuilderTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 04/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class BeagleViewBuilderTests: XCTestCase {

    
    func test_buildFromRootWidget_shouldReturnTheExpectedRootView() {
        // Given
        let sut = BeagleViewBuilding()
        let widget = Text("Text")
        let context = BeagleContextDummy()
        
        // When
        let rootView = sut.buildFromRootWidget(widget, context: context)
        
        // Then
        XCTAssertTrue(rootView is UILabel, "Expected a `UITextField`, but got \(String(describing: rootView)).")
    }
    
}


