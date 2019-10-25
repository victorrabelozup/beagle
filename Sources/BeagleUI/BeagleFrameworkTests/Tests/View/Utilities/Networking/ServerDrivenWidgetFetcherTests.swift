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
    
    func test_whenRequestSucceeds_butDecodingFailsBecauseOfAnOnvalidEntity_itShouldThrowInvalidEntityError() {
        // Given
        guard let jsonData = """
        {
            "type": "beagle:UnconvertibleWidget",
            "text": "some text"
        }
        """.data(using: .utf8) else {
            XCTFail("Could not create test data.")
            return
        }
        let dispatcherStub = URLRequestDispatchingStub(resultToReturn: .success(jsonData))
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
        guard case .invalidEntity = errorThrown else {
            XCTFail("Expected a `.invalidEntity` error, but got \(String(describing: errorThrown)).")
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
