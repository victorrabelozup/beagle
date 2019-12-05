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
    
    func test_requestWithInvalidURL_itShouldFail() {
        let sut = ServerDrivenWidgetFetching(
            baseURL: nil,
            networkingDispatcher: URLRequestDispatchingDummy(),
            decoder: WidgetDecodingDummy()
        )
        let invalidURL = "🥶"
        
        // When
        let fetchWidgetExpectation = expectation(description: "fetchWidget")
        var fetchError: ServerDrivenWidgetFetcherError?
        sut.fetchWidget(from: invalidURL) { result in
            if case let .failure(error) = result {
                fetchError = error
            }
            fetchWidgetExpectation.fulfill()
        }
        let submitFormExpectation = expectation(description: "submitForm")
        var formError: ServerDrivenWidgetFetcherError?
        sut.submitForm(action: invalidURL, method: .post, values: [:]) { result in
            if case let .failure(error) = result {
                formError = error
            }
            submitFormExpectation.fulfill()
        }
        wait(for: [fetchWidgetExpectation, submitFormExpectation], timeout: 1.0)

        // Then
        XCTAssertNotNil(fetchError)
        XCTAssertNotNil(formError)
        guard
            case .invalidURL = fetchError,
            case .invalidURL = formError else
        {
            let errorName = String(describing: fetchError ?? formError)
            XCTFail("Expected a `.invalidURL` error, but got \(errorName).")
            return
        }
    }
    
    func test_fetchWitdget_withBaseURL_buildTheProperURL() {
        let baseURL = URL(string: "http://test.me/api/ignored")
        let dispatchingSpy = URLRequestDispatchingSpy()
        let sut = ServerDrivenWidgetFetching(
            baseURL: baseURL,
            networkingDispatcher: dispatchingSpy,
            decoder: WidgetDecodingDummy()
        )
        let expectedURLs = [
            "xyz": "http://test.me/api/xyz",
            "/xyz" : "http://test.me/xyz",
            "xyz?abc=123#anchor": "http://test.me/api/xyz?abc=123#anchor",
            "https://absolute.url/api/v2/endpoint": "https://absolute.url/api/v2/endpoint",
        ]
        
        // When/Then
        expectedURLs.forEach {
            sut.fetchWidget(from: $0.key) { _ in
            }
            let absoluteURL = dispatchingSpy.executedRequest?.baseURL.absoluteString
            XCTAssertEqual(absoluteURL, $0.value)
        }
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
            baseURL: nil,
            networkingDispatcher: dispatcherStub,
            decoder: WidgetDecoder()
        )
        let url = "www.something.com"

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
            baseURL: nil,
            networkingDispatcher: dispatcherStub,
            decoder: WidgetDecodingDummy()
        )
        let url = "www.something.com"

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
            baseURL: nil,
            networkingDispatcher: dispatcherStub,
            decoder: WidgetDecodingDummy()
        )
        let url = "www.something.com"

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
            baseURL: nil,
            networkingDispatcher: dispatcherStub,
            decoder: decoderStub
        )
        let url = "www.something.com"

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
    
    func test_whenSubmitForm_itShoudConfigureTheParameters() {
        // Given
        let dispatcherSpy = URLRequestDispatchingSpy()
        let sut = ServerDrivenWidgetFetching(
            baseURL: nil,
            networkingDispatcher: dispatcherSpy,
            decoder: WidgetDecodingDummy()
        )
        let urlParamMethods: [Form.MethodType] = [.get, .delete]
        let bodyParamMethods: [Form.MethodType] = [.post, .put]
        let values = ["p1": "1", "p2": "2"]
        let url = "https://form.com/submit"
        
        // Then/When
        for method in urlParamMethods {
            sut.submitForm(action: url, method: method, values: values) { _ in
            }
            guard let parameters = dispatcherSpy.executedRequest?.parameters else {
                XCTFail("Parameters form method \(method) should not be nil")
                return
            }
            if case let Networking.URLRequestParameters.url(urlParams) = parameters {
                XCTAssertEqual(urlParams, values)
            } else {
                XCTFail("Method \(method) should have url parameters")
            }
        }
        for method in bodyParamMethods {
            sut.submitForm(action: url, method: method, values: values) { _ in
            }
            guard let parameters = dispatcherSpy.executedRequest?.parameters else {
                XCTFail("Parameters form method \(method) should not be nil")
                return
            }
            if case let Networking.URLRequestParameters.body(bodyParams) = parameters {
                let stringParams = bodyParams?.reduce(into: [String: String]()) {
                    if let value = $1.value as? String {
                        $0[$1.key] = value
                    }
                }
                XCTAssertEqual(stringParams, values)
            } else {
                XCTFail("Method \(method) should have url parameters")
            }
        }
    }
    
    func test_whenFormSubmitRequestFails_itShouldThrowRequestError() {
        // Given
        let dispatcherStub = URLRequestDispatchingStub(resultToReturn: .failure(.unknown))
        let sut = ServerDrivenWidgetFetching(
            baseURL: nil,
            networkingDispatcher: dispatcherStub,
            decoder: WidgetDecodingDummy()
        )
        let url = "www.something.com"

        // When
        var errorThrown: ServerDrivenWidgetFetcherError?
        let submitFormExpectation = expectation(description: "submitFormExpectation")
        sut.submitForm(action: url, method: .post, values: [:]) { result in
            if case let .failure(error) = result {
                errorThrown = error
            }
            submitFormExpectation.fulfill()
        }
        wait(for: [submitFormExpectation], timeout: 1.0)

        // Then
        XCTAssertNotNil(errorThrown, "Expected an error, but got nil.")
        guard case .request = errorThrown else {
            XCTFail("Expected a `.request` error, but got \(String(describing: errorThrown)).")
            return
        }
    }

    func test_whenFormSubmitRequestSucceeds_withNilData_itShouldThrowEmptyDataError() {
        // Given
        let dispatcherStub = URLRequestDispatchingStub(resultToReturn: .success(nil))
        let sut = ServerDrivenWidgetFetching(
            baseURL: nil,
            networkingDispatcher: dispatcherStub,
            decoder: WidgetDecodingDummy()
        )
        let url = "www.something.com"

        // When
        var errorThrown: ServerDrivenWidgetFetcherError?
        let submitFormExpectation = expectation(description: "submitFormExpectation")
        sut.submitForm(action: url, method: .post, values: [:]) { result in
            if case let .failure(error) = result {
                errorThrown = error
            }
            submitFormExpectation.fulfill()
        }
        wait(for: [submitFormExpectation], timeout: 1.0)

        // Then
        XCTAssertNotNil(errorThrown, "Expected an error, but got nil.")
        guard case .emptyData = errorThrown else {
            XCTFail("Expected a `.emptyData` error, but got \(String(describing: errorThrown)).")
            return
        }
    }

    func test_whenFormSubmitRequestSucceeds_butTheDecodingFailsWithAnError_itShouldThrowDecodingError() {
        // Given
        let dispatcherStub = URLRequestDispatchingStub(resultToReturn: .success(Data()))
        let decoderStub = WidgetDecodingStub()
        decoderStub.errorToThrowOnDecode = NSError(domain: "Mock", code: 1, description: "Mock")
        let sut = ServerDrivenWidgetFetching(
            baseURL: nil,
            networkingDispatcher: dispatcherStub,
            decoder: decoderStub
        )
        let url = "www.something.com"

        // When
        var errorThrown: ServerDrivenWidgetFetcherError?
        let submitFormExpectation = expectation(description: "submitFormExpectation")
        sut.submitForm(action: url, method: .post, values: [:]) { result in
            if case let .failure(error) = result {
                errorThrown = error
            }
            submitFormExpectation.fulfill()
        }
        wait(for: [submitFormExpectation], timeout: 1.0)

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

final class URLRequestDispatchingSpy: URLRequestDispatching {
    private(set) var executedRequest: URLRequestProtocol?
    func execute(on queue: DispatchQueue, request: URLRequestProtocol, completion: @escaping (Result<Data?, URLRequestError>) -> Void) -> URLRequestToken? {
        executedRequest = request
        return nil
    }
}

final class WidgetDecodingStub: WidgetDecoding {
    
    func register<T>(_ type: T.Type, for typeName: String) where T : WidgetEntity {}

    var widgetToReturnOnDecode: WidgetEntity?
    var errorToThrowOnDecode: Error?
    
    func decodeWidget(from data: Data) throws -> Widget {
        if let error = errorToThrowOnDecode {
            throw error
        }
        return WidgetDummy()
    }

    func decodeAction(from data: Data) throws -> Action {
        if let error = errorToThrowOnDecode {
            throw error
        }
        return ActionDummy()
    }
}

private struct MappingFailureWidget: WidgetEntity, WidgetConvertible {
    func mapToWidget() throws -> Widget {
        throw NSError(domain: "Tests", code: -1, description: "MappingFailureWidget")
    }
}
