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
        let jsonData = """
        {
            "_beagleType_": "custom:component:newcomponent",
            "something": "something"
        }
        """.data(using: .utf8)!

        // When
        sut.register(NewComponentEntity.self, for: "NewComponent")

        // Then
        let text = try sut.decodeComponent(from: jsonData) as? Text
        XCTAssert(text != nil)
        XCTAssert(text?.text == "something")
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
        XCTAssert(text != nil)
        XCTAssert(text?.text == expectedText)
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
        let anyComponent = try sut.decodeComponent(from: jsonData) as? AnyComponent
        let value = anyComponent?.value as? Unknown

        // Then
        XCTAssert(value?.type == "beagle:component:unknown")
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
public struct NewComponentEntity: ComponentEntity, ComponentConvertible {
    
    let something: String
    
    public func mapToComponent() throws -> ServerDrivenComponent {
        return Text(something)
    }
}

struct UnconvertibleComponent: ComponentEntity {
    let text: String
}
