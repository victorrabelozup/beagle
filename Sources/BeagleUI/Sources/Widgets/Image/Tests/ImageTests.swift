//
//  Copyright © 30/12/19 Zup IT. All rights reserved.
//

@testable import BeagleUI
import XCTest
import SnapshotTesting
import YogaKit

class ImageTests: XCTestCase {
    
    private let dependencies = RendererDependenciesContainer()
    
    func test_toView_shouldReturnTheExpectedView() throws {
        //Given
        let expectedContentMode = UIImageView.ContentMode.scaleToFill
        let widget = Image(name: "teste", contentMode: .fitXY)
        
        //When
        guard let imageView = widget.toView(context: BeagleContextDummy(), dependencies: dependencies) as? UIImageView else {
            XCTFail("Build View not returning UIImageView")
            return
        }
        
        // Then
        XCTAssertEqual(expectedContentMode, imageView.contentMode)
    }

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
