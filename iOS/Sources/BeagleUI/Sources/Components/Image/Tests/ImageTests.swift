/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

@testable import BeagleUI
import XCTest
import SnapshotTesting

class ImageTests: XCTestCase {
    
    private let dependencies = BeagleScreenDependencies()
    
    func test_toView_shouldReturnTheExpectedView() throws {
        //Given
        let expectedContentMode = UIImageView.ContentMode.scaleToFill
        let component = Image(name: "teste", contentMode: .fitXY)
        
        //When
        guard let imageView = component.toView(context: BeagleContextDummy(), dependencies: dependencies) as? UIImageView else {
            XCTFail("Build View not returning UIImageView")
            return
        }
        
        // Then
        XCTAssertEqual(expectedContentMode, imageView.contentMode)
    }

    func test_whenDecodingJson_thenItShouldReturnAnImage() throws {
        let component: Image = try componentFromJsonFile(fileName: "ImageComponent")
        assertSnapshot(matching: component, as: .dump)
    }
    
    func test_renderImage() throws {
        let dependencies = BeagleDependencies()
        dependencies.appBundle = Bundle(for: ImageTests.self)
        Beagle.dependencies = dependencies
        addTeardownBlock {
            Beagle.dependencies = BeagleDependencies()
        }

        let image: Image = try componentFromJsonFile(fileName: "ImageComponent")
        let view = image.toView(context: BeagleContextDummy(), dependencies: dependencies)
        assertSnapshotImage(view, size: CGSize(width: 400, height: 400))
    }
}
