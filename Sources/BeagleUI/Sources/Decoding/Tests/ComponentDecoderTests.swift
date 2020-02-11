//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI
import SnapshotTesting

final class ComponentDecoderTests: XCTestCase {
    
    // MARK: - Properties
    
    private lazy var sut = Beagle.dependencies.decoder
    
    // MARK: - Tests

    // TODO: remove this test when using newer versions of SnapshotTesting,
    // because this behaviour will be already tested on BeagleSetupTests.
    func testIfAllDecodersAreBeingRegistered() {
        let decoder = ComponentDecoder(jsonDecoder: .init(), namespace: "TEST")
        assertSnapshot(matching: decoder.decoders, as: .dump)
    }
    
    func test_initWithCustomJsonDecoder_shouldSetupJsonDecoderCorrectly() {
        // Given
        let customDecoder = JSONDecoder()
        
        // When
        let sut = ComponentDecoder(jsonDecoder: customDecoder)
        let custom = Mirror(reflecting: sut).firstChild(of: JSONDecoder.self)
        
        // Then
        XCTAssertTrue(customDecoder === custom)
    }
    
    func test_whenANewTypeIsRegistered_thenItShouldBeAbleToDecodeIt() {
        // Given
        guard let jsonData = """
        {
            "_beagleType_": "beagle:component:newcomponent",
            "something": "something"
        }
        """.data(using: .utf8) else {
            XCTFail("Could not create test data.")
            return
        }

        // When
        sut.register(NewComponentEntity.self, for: "NewComponent")

        // Then
        let component: ServerDrivenComponent? = try? sut.decodeComponent(from: jsonData)
        let value = component as? Text
        XCTAssertNotNil(value, "Expected a Text, but found nil.")
        XCTAssertEqual("something", value?.text)
    }

    func test_whenADefaultTypeIsRequested_thenItShouldBeAbleToDecodeIt() {
        // Given
        guard let jsonData = """
        {
            "_beagleType_": "beagle:component:text",
            "text": "some text"
        }
        """.data(using: .utf8) else {
            XCTFail("Could not create test data.")
            return
        }

        // When
        let component: ServerDrivenComponent? = try? sut.decodeComponent(from: jsonData)
        let value = component as? Text

        // Then
        XCTAssertNotNil(value, "Expected a Text, but found nil.")
        XCTAssertEqual("some text", value?.text)
    }

    func test_whenAnUnknwonTypeIsDecoded_thenItShouldReturnNil() {
        // Given
        guard let jsonData = """
        {
            "_beagleType_": "beagle:component:unknown",
            "text": "some text"
        }
        """.data(using: .utf8) else {
            XCTFail("Could not create test data.")
            return
        }

        // When
        let component: ServerDrivenComponent? = try? sut.decodeComponent(from: jsonData)
        let anyComponent = component as? AnyComponent
        let value = anyComponent?.value as? Unknown

        // Then
        XCTAssertEqual("beagle:component:unknown", value?.type)
    }
}

// MARK: - Testing Helpers
private struct NewComponentEntity: ComponentEntity, ComponentConvertible {
    
    let something: String
    
    func mapToComponent() throws -> ServerDrivenComponent {
        return Text(something)
    }
    
}

struct UnconvertibleComponent: ComponentEntity {
    let text: String
}
