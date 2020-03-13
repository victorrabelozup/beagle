//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI
import SnapshotTesting

final class ComponentDecoderTests: XCTestCase {
    // swiftlint:disable force_unwrapping
    
    private lazy var sut = Beagle.dependencies.decoder

    // TODO: remove this test when using newer versions of SnapshotTesting,
    // because this behaviour will be already tested on BeagleSetupTests.
    func testIfAllDecodersAreBeingRegistered() {
        let sut = ComponentDecoder()
        assertSnapshot(matching: sut.decoders, as: .dump)
    }
    
    func test_whenANewTypeIsRegistered_thenItShouldBeAbleToDecodeIt() throws {
        // Given
        let expectedText = "something"
        let jsonData = """
        {
            "_beagleType_": "custom:component:newcomponent",
            "text": "\(expectedText)"
        }
        """.data(using: .utf8)!

        // When
        sut.register(NewComponent.self, for: "NewComponent")
        let component = try sut.decodeComponent(from: jsonData) as? NewComponent
        
        // Then
        XCTAssertEqual(component?.text, expectedText)
    }

    func testDecodeDefaultType() throws {
        // Given
        let expectedText = "some text"
        let jsonData = """
        {
            "_beagleType_": "beagle:component:text",
            "text": "\(expectedText)"
        }
        """.data(using: .utf8)!

        // When
        let text = try sut.decodeComponent(from: jsonData) as? Text

        // Then
        XCTAssertEqual(text?.text, expectedText)
    }

    func test_whenAnUnknwonTypeIsDecoded_thenItShouldReturnNil() throws {
        // Given
        let jsonData = """
        {
            "_beagleType_": "beagle:component:unknown",
            "text": "some text"
        }
        """.data(using: .utf8)!

        // When
        let unknown = try sut.decodeComponent(from: jsonData) as? UnknownComponent

        // Then
        XCTAssert(unknown?.type == "beagle:component:unknown")
    }

    func testDecodeAction() throws {
        let jsonData = """
        {
            "_beagleType_": "beagle:action:navigate",
            "type": "FINISH_VIEW"
        }
        """.data(using: .utf8)!

        let action = try sut.decodeAction(from: jsonData)

        guard case Navigate.finishView = action else {
            XCTFail("decoding failed"); return
        }
    }
}

// MARK: - Testing Helpers
struct NewComponent: ServerDrivenComponent {
    var text: String
    
    func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        return UIView()
    }
}

struct Unknown: ServerDrivenComponent {
    func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        return UIView()
    }
}
