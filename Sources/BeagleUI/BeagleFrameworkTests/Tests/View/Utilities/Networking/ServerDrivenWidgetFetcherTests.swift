//
//  ServerDrivenWidgetFetcherTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 25/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI
import Networking

final class ServerDrivenWidgetFetcherTests: XCTestCase {
    
    func test_publicInit_shouldConfigureDependenciesFromEnvironment() {
        // Given
        let environmentSpy = BeagleEnvironmentSpy.self
        Beagle.environment = environmentSpy
        Beagle.didCallStart = false
        Beagle.start()

        // When
        _ = ServerDrivenWidgetFetching()

        // Then
        XCTAssertEqual(environmentSpy._shared?.networkingDispatcherCalled, true, "Init should call environment's `networkingDispatcher`.")
        XCTAssertEqual(environmentSpy._shared?.decoderCalled, true, "Init should call environment's `decoder`.")
    }
    
    func test_whenRequestSucceeds_withValidData_itShouldReturnSomeWidget() {
        // Given
        guard let jsonData = """
        {
            "_beagleType_": "beagle:widget:text",
            "text": "some text"
        }
        """.data(using: .utf8) else {
            XCTFail("Could not create test data.")
            return
        }
        let dispatcherStub = URLRequestDispatchingStub(resultToReturn: .success(jsonData))
        let sut = ServerDrivenWidgetFetching(
            networkingDispatcher: dispatcherStub,
            decoder: WidgetDecoder()
        )
        guard let url = URL(string: "www.something.com") else {
            XCTFail("Could not create URL.")
            return
        }

        // When
        var widgetReturned: Widget?
        let fetchWidgetExpectation = expectation(description: "fetchWidgetExpectation")
        sut.fetchWidget(from: url) { result in
            if case let .success(widget) = result {
                widgetReturned = widget
            }
            fetchWidgetExpectation.fulfill()
        }
        wait(for: [fetchWidgetExpectation], timeout: 1.0)

        // Then
        XCTAssertNotNil(widgetReturned, "Expected a widget, but got nil.")
        XCTAssertTrue(widgetReturned is Text, "Expected a `Text`, but got something else.")
    }

    func test_whenRequestFails_itShouldThrowRequestError() {
        // Given
        let dispatcherStub = URLRequestDispatchingStub(resultToReturn: .failure(.unknown))
        let sut = ServerDrivenWidgetFetching(
            networkingDispatcher: dispatcherStub,
            decoder: WidgetDecodingDummy()
        )
        guard let url = URL(string: "www.something.com") else {
            XCTFail("Could not create URL.")
            return
        }

        // When
        var errorThrown: ServerDrivenWidgetFetcherError?
        let fetchWidgetExpectation = expectation(description: "fetchWidgetExpectation")
        sut.fetchWidget(from: url) { result in
            if case let .failure(error) = result {
                errorThrown = error
            }
            fetchWidgetExpectation.fulfill()
        }
        wait(for: [fetchWidgetExpectation], timeout: 1.0)

        // Then
        XCTAssertNotNil(errorThrown, "Expected an error, but got nil.")
        guard case .request = errorThrown else {
            XCTFail("Expected a `.request` error, but got \(String(describing: errorThrown)).")
            return
        }

    }

    func test_whenRequestSucceeds_withNilData_itShouldThrowEmptyDataError() {
        // Given
        let dispatcherStub = URLRequestDispatchingStub(resultToReturn: .success(nil))
        let sut = ServerDrivenWidgetFetching(
            networkingDispatcher: dispatcherStub,
            decoder: WidgetDecodingDummy()
        )
        guard let url = URL(string: "www.something.com") else {
            XCTFail("Could not create URL.")
            return
        }

        // When
        var errorThrown: ServerDrivenWidgetFetcherError?
        let fetchWidgetExpectation = expectation(description: "fetchWidgetExpectation")
        sut.fetchWidget(from: url) { result in
            if case let .failure(error) = result {
                errorThrown = error
            }
            fetchWidgetExpectation.fulfill()
        }
        wait(for: [fetchWidgetExpectation], timeout: 1.0)

        // Then
        XCTAssertNotNil(errorThrown, "Expected an error, but got nil.")
        guard case .emptyData = errorThrown else {
            XCTFail("Expected a `.emptyData` error, but got \(String(describing: errorThrown)).")
            return
        }

    }

    func test_whenRequestSucceeds_butTheDecodingFailsWithAnError_itShouldThrowDecodingError() {
        // Given
        let dispatcherStub = URLRequestDispatchingStub(resultToReturn: .success(Data()))
        let decoderStub = WidgetDecodingStub()
        decoderStub.errorToThrowOnDecode = NSError(domain: "Mock", code: 1, description: "Mock")
        let sut = ServerDrivenWidgetFetching(
            networkingDispatcher: dispatcherStub,
            decoder: decoderStub
        )
        guard let url = URL(string: "www.something.com") else {
            XCTFail("Could not create URL.")
            return
        }

        // When
        var errorThrown: ServerDrivenWidgetFetcherError?
        let fetchWidgetExpectation = expectation(description: "fetchWidgetExpectation")
        sut.fetchWidget(from: url) { result in
            if case let .failure(error) = result {
                errorThrown = error
            }
            fetchWidgetExpectation.fulfill()
        }
        wait(for: [fetchWidgetExpectation], timeout: 1.0)

        // Then
        XCTAssertNotNil(errorThrown, "Expected an error, but got nil.")
        guard case .decoding = errorThrown else {
            XCTFail("Expected a `.decoding` error, but got \(String(describing: errorThrown)).")
            return
        }

    }
}

// MARK: - Testing Helpers

final class URLRequestDispatchingStub: URLRequestDispatching {

    private let resultToReturn: Result<Data?, URLRequestError>

    init(resultToReturn: Result<Data?, URLRequestError>) {
        self.resultToReturn = resultToReturn
    }

    func execute(on queue: DispatchQueue, request: URLRequestProtocol, completion: @escaping (Result<Data?, URLRequestError>) -> Void) -> URLRequestToken? {
           completion(resultToReturn)
           return nil
    }

}

final class WidgetDecodingStub: WidgetDecoding {
    
    func register<T>(_ type: T.Type, for typeName: String) where T : WidgetEntity {}

    var widgetToReturnOnDecode: WidgetEntity?
    var errorToThrowOnDecode: Error?
    
    func decode(from data: Data) throws -> Widget {
        if let error = errorToThrowOnDecode {
            throw error
        }
        return WidgetDummy()
    }

}

private struct MappingFailureWidget: WidgetEntity, WidgetConvertible {
    func mapToWidget() throws -> Widget {
        throw NSError(domain: "Tests", code: -1, description: "MappingFailureWidget")
    }
}
