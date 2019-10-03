//
//  URLSessionAbstractionsTests.swift
//  NetworkingTests
//
//  Created by Gabriela Coelho on 02/10/19.
//  Copyright © 2019 Bocato. All rights reserved.
//


import XCTest
@testable import Networking

final class URLSessionAbstractionsTests: XCTestCase {
    
    func test_urlSessionDataTaskCalled_shouldReturnURLSessionDataTaskProtocol() {
        // Given
        guard let url = URL(string: "http://www.someurl.com/") else {
            XCTFail("Could not create an URL.")
            return
        }
        let session = URLSession.shared
        let urlRequest = NSURLRequest(url: url)
        
        // When
        let sut = session.dataTask(with: urlRequest) { (data, response, error) in
            XCTFail("Unable to create session.")
        }
        // Then
        XCTAssertNotNil(sut, "Expected a session, but got nil.")
    }
}
