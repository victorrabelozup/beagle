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
    
    func test_renderImage() throws {
        let dependencies = BeagleDependencies()
        dependencies.appBundle = Bundle(for: ImageTests.self)
        Beagle.dependencies = dependencies
        addTeardownBlock {
            Beagle.dependencies = BeagleDependencies()
        }

        let image: Image = try widgetFromJsonFile(fileName: "ImageWidget")
        let view = image.toView(context: BeagleContextDummy(), dependencies: dependencies)
        assertSnapshotImage(view, size: CGSize(width: 400, height: 400))
    }
}
