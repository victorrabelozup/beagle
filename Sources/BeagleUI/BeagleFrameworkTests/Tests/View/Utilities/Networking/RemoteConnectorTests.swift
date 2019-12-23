//
//  Copyright © 25/10/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class RemoteConnectorTests: XCTestCase {

    private struct Dependencies: RemoteConnecting.Dependencies {
        var baseURL: URL? = nil
        var networkDispatcher: NetworkDispatcher = URLRequestDispatchingDummy()
        var decoder: WidgetDecoding = WidgetDecodingDummy()
    }

    func test_requestWithInvalidURL_itShouldFail() {
        let sut = RemoteConnecting(dependencies: Dependencies())
        let invalidURL = "🥶"
        
        // When
        let fetchWidgetExpectation = expectation(description: "fetchWidget")
        var fetchError: RemoteConnectorError?
        sut.fetchWidget(from: invalidURL) { result in
            if case let .failure(error) = result {
                fetchError = error
            }
            fetchWidgetExpectation.fulfill()
        }
        let submitFormExpectation = expectation(description: "submitForm")
        var formError: RemoteConnectorError?
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
        let dispatchingSpy = NetworkDispatcherSpy()
        let sut = RemoteConnecting(dependencies: Dependencies(
            baseURL: URL(string: "http://test.me/api/ignored"),
            networkDispatcher: dispatchingSpy
        ))

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
        let sut = RemoteConnecting(dependencies: Dependencies(
            networkDispatcher: dispatcherStub,
            decoder: WidgetDecoder()
        ))
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
        let sut = RemoteConnecting(dependencies: Dependencies(
            networkDispatcher: dispatcherStub
        ))
        let url = "www.something.com"

        // When
        var errorThrown: RemoteConnectorError?
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
        let sut = RemoteConnecting(dependencies: Dependencies(
            networkDispatcher: dispatcherStub
        ))

        let url = "www.something.com"

        // When
        var errorThrown: RemoteConnectorError?
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
        let sut = RemoteConnecting(dependencies: Dependencies(
            networkDispatcher: dispatcherStub,
            decoder: decoderStub
        ))

        let url = "www.something.com"

        // When
        var errorThrown: RemoteConnectorError?
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
        let dispatcherSpy = NetworkDispatcherSpy()
        let sut = RemoteConnecting(dependencies: Dependencies(
            networkDispatcher: dispatcherSpy
        ))

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
            if case let URLRequestParameters.url(urlParams) = parameters {
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
            if case let URLRequestParameters.body(bodyParams) = parameters {
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
        let sut = RemoteConnecting(dependencies: Dependencies(
            networkDispatcher: dispatcherStub
        ))
        let url = "www.something.com"

        // When
        var errorThrown: RemoteConnectorError?
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
        let sut = RemoteConnecting(dependencies: Dependencies(
            networkDispatcher: dispatcherStub
        ))
        let url = "www.something.com"

        // When
        var errorThrown: RemoteConnectorError?
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
        let sut = RemoteConnecting(dependencies: Dependencies(
            networkDispatcher: dispatcherStub,
            decoder: decoderStub
        ))
        let url = "www.something.com"

        // When
        var errorThrown: RemoteConnectorError?
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

final class NetworkDispatcherSpy: NetworkDispatcher {
    private(set) var executedRequest: URLRequestProtocol?
    func execute(on queue: DispatchQueue, request: URLRequestProtocol, completion: @escaping (Result<Data?, URLRequestError>) -> Void) -> URLRequestToken? {
        executedRequest = request
        return nil
    }
}

final class WidgetDecodingStub: WidgetDecoding {
    
    func register<T>(_ type: T.Type, for typeName: String) where T : WidgetEntity {}
    func decodableType(forType type: String) -> Decodable.Type? { return nil }

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

final class RemoteConnectorSpy: RemoteConnector {
    private(set) var fetchWidgetCalled = false
    private(set) var submitFormCalled = false
    func submitForm(action: String, method: Form.MethodType, values: [String : String], completion: @escaping FormCompletion) {
        submitFormCalled = true
    }
    func fetchWidget(from url: String, completion: @escaping WidgetCompletion) {
        fetchWidgetCalled = true
    }
}
