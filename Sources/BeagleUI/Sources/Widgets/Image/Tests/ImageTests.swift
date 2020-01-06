//
//  Copyright © 30/12/19 Zup IT. All rights reserved.
//

@testable import BeagleUI
import XCTest
import SnapshotTesting
import YogaKit

class ImageTests: XCTestCase {

    func test_whenDecodingJson_thenItShouldReturnAnImage() throws {
        let widget: Image = try widgetFromJsonFile(fileName: "ImageWidget")
        assertSnapshot(matching: widget, as: .dump)
    }
    
    func test_renderImage() {
        let dependencies = BeagleDependencies()
        dependencies.appBundle = Bundle(for: ImageTests.self)
        Beagle.dependencies = dependencies
        addTeardownBlock {
            Beagle.dependencies = BeagleDependencies()
        }
        guard let image: Image = try? widgetFromJsonFile(fileName: "ImageWidget") else {
            XCTFail("Failed to load ImageWidget.json")
            return
        }
        let screen = BeagleScreenViewController(
            viewModel: .init(screenType: .declarative(image))
        )
        assertSnapshot(matching: screen, as: .image)
    }

}
