//
//  Copyright © 25/10/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class NetworkTests: XCTestCase {

    private struct Dependencies: NetworkDefault.Dependencies {
        var baseURL: URL?
        var networkClient: NetworkClient
        var decoder: WidgetDecoding

        init(
            baseURL: URL? = nil,
            networkClient: NetworkClient = NetworkClientDummy(),
            decoder: WidgetDecoding = WidgetDecodingDummy()
        ) {
            self.baseURL = baseURL
            self.networkClient = networkClient
            self.decoder = decoder
        }
    }

    func test_requestWithInvalidURL_itShouldFail() {
        let sut = NetworkDefault(dependencies: BeagleDependencies())
        let invalidURL = "🥶"
        
        // When
        let fetchWidgetExpectation = expectation(description: "fetchWidget")
        var fetchError: Request.Error?

        sut.fetchWidget(url: invalidURL) {
            if case let .failure(error) = $0 {
                fetchError = error
            }
            fetchWidgetExpectation.fulfill()
        }

        let submitFormExpectation = expectation(description: "submitForm")
        var formError: Request.Error?
        let formData = Request.FormData(
            method: .post, values: [:]
        )

        sut.submitForm(url: invalidURL, data: formData) {
            if case let .failure(error) = $0 {
                formError = error
            }
            submitFormExpectation.fulfill()
        }
        wait(for: [fetchWidgetExpectation, submitFormExpectation], timeout: 1.0)

        // Then
        guard
            case .networkError? = fetchError,
            case .networkError? = formError
        else {
            XCTFail("Expected an error")
            return
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
        let clientStub = NetworkDispatcherStub(result: .success(jsonData))
        let sut = NetworkDefault(dependencies: Dependencies(
            networkClient: clientStub,
            decoder: WidgetDecoder()
        ))
        let url = "www.something.com"

        // When
        var widgetReturned: Widget?
        let expec = expectation(description: "fetchWidgetExpectation")
        sut.fetchWidget(url: url) { result in
            if case .success(let widget) = result {
                widgetReturned = widget
            }
            expec.fulfill()
        }
        wait(for: [expec], timeout: 1.0)

        // Then
        XCTAssertNotNil(widgetReturned)
        XCTAssert(widgetReturned is Text)
    }

    func test_whenRequestSucceeds_butTheDecodingFailsWithAnError_itShouldThrowDecodingError() {
        // Given
        let clientStub = NetworkDispatcherStub(result: .success(Data()))
        let decoderStub = WidgetDecodingStub()
        decoderStub.errorToThrowOnDecode = NSError(domain: "Mock", code: 1, description: "Mock")
        let sut = NetworkDefault(dependencies: Dependencies(
            networkClient: clientStub,
            decoder: decoderStub
        ))

        let url = "www.something.com"

        // When
        var errorThrown: Request.Error?
        let expec = expectation(description: "fetchWidgetExpectation")
        sut.fetchWidget(url: url) { result in
            if case let .failure(error) = result {
                errorThrown = error
            }
            expec.fulfill()
        }
        wait(for: [expec], timeout: 1.0)

        // Then
        XCTAssertNotNil(errorThrown)
        guard case .decoding? = errorThrown else {
            XCTFail("Expected a `.decoding` error, but got \(String(describing: errorThrown)).")
            return
        }
    }
}

// MARK: - Testing Helpers

final class NetworkClientSpy: NetworkClient {
    private(set) var executedRequest: Request?

    func executeRequest(_ request: Request, completion: @escaping RequestCompletion) -> RequestToken? {
        executedRequest = request
        return nil
    }
}

final class WidgetDecodingStub: WidgetDecoding {
    
    func register<T>(_ type: T.Type, for typeName: String) where T: WidgetEntity {}
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

final class NetworkSpy: Network {
    private(set) var didCallDispatch = false
    private(set) var token = Token()

    class Token: RequestToken {
        var didCallCancel = false

        func cancel() {
            didCallCancel = true
        }
    }

    func fetchWidget(url: String, completion: @escaping (Result<Widget, Request.Error>) -> Void) -> RequestToken? {
        didCallDispatch = true
        return token
    }

    func submitForm(url: String, data: Request.FormData, completion: @escaping (Result<Action, Request.Error>) -> Void) -> RequestToken? {
        didCallDispatch = true
        return token
    }

    func fetchImage(url: String, completion: @escaping (Result<Data, Request.Error>) -> Void) -> RequestToken? {
        didCallDispatch = true
        return token
    }
}
