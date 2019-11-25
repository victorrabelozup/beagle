//
//  NetworkUIImageViewTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 11/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
import Caching
import Networking
@testable import BeagleUI

final class NetworkUIImageViewTests: XCTestCase {
    func test_onCancellingRequestOnNetworkUIImage_shouldCancel() {
        // Given
        let urlRequestDispatchingStub = URLRequestDispatchingStub(resultToReturn:
            .success(nil))
        let imageDataProviderStub = ImageDataProvidingStub(dispatcher: urlRequestDispatchingStub, resultToReturn: .success(Data()))

        // When
        let sut = NetworkUIImageView(imageDataProvider: imageDataProviderStub, url: "www.forCancel.com")
        sut.cancelHTTPRequest()

        // Then
        XCTAssertTrue(imageDataProviderStub.urlRequestToken.cancelFunctionCalled, "Expected cancelFunction to be called, but it was not.")
    }

    func test_onCallingNetworkUIImageViewInitializer_shouldReturnNetworkUIImageView() {
        // Given
        let data = Data()
        let urlRequestDispatchingStub = URLRequestDispatchingStub(resultToReturn:
        .success(data))
        let imageDataProvider = ImageDataProviding(dispatcher: urlRequestDispatchingStub)

        // When
        let networkUIImageView = NetworkUIImageView(imageDataProvider: imageDataProvider, url: "www.some.com")

        // Then
        XCTAssertNotNil(networkUIImageView, "Expected to have created a networkUIImageView, but it has not.")
    }
}

final class URLRequestTokenSpy: URLRequestToken {
    var cancelFunctionCalled = false
    
    func cancel() {
        cancelFunctionCalled = true
    }
    
    func resume() {}
}

private class ImageDataProvidingStub: ImageDataProvider {
    var dispatcher: URLRequestDispatching
    var urlRequestToken = URLRequestTokenSpy()
    let resultToReturn: Result<Data, ImageDataProviderError>

    init(dispatcher: URLRequestDispatching, resultToReturn: Result<Data, ImageDataProviderError>) {
        self.dispatcher = dispatcher
        self.resultToReturn = resultToReturn
    }
    
    func fetchImageData(from urlString: String, completion: @escaping (Result<Data, ImageDataProviderError>) -> Void) -> URLRequestToken? {
        completion(resultToReturn)
        return urlRequestToken
    }
}
