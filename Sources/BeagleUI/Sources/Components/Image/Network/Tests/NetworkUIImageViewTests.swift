//
//  Copyright © 11/11/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class NetworkUIImageViewTests: XCTestCase {
    func test_onCancellingRequestOnNetworkUIImage_shouldCancel() {
        // Given
        let network = NetworkSpy()

        // When
        let sut = NetworkUIImageView(network: network, url: "www.forCancel.com")
        sut.cancelHTTPRequest()

        // Then
        XCTAssert(network.token.didCallCancel)
    }

    func test_onCallingNetworkUIImageViewInitializer_shouldReturnNetworkUIImageView() {
        // Given
        let data = Data()
        let network = NetworkStub(imageResult: .success(data))

        // When
        let networkUIImageView = NetworkUIImageView(network: network, url: "www.some.com")

        // Then
        XCTAssertNotNil(networkUIImageView)
    }
}

final class URLRequestTokenSpy: RequestToken {
    var cancelFunctionCalled = false
    
    func cancel() {
        cancelFunctionCalled = true
    }
    
    func resume() {}
}
