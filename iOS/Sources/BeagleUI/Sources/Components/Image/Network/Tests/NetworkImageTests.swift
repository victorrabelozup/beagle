/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import XCTest
@testable import BeagleUI

final class NetworkImageTests: XCTestCase {

    private let dependencies = BeagleScreenDependencies()
    
    func test_withInvalidURL_itShouldNotSetImage() throws {
        // Given
        let component = NetworkImage(path: "www.com")
        
        // When
        guard let imageView = component.toView(context: BeagleContextDummy(), dependencies: BeagleScreenDependencies()) as? UIImageView else {
            XCTFail("Build view not returning UIImageView")
            return
        }
        
        // Then
        XCTAssertNil(imageView.image, "Expected image to be nil.")
    }
}
