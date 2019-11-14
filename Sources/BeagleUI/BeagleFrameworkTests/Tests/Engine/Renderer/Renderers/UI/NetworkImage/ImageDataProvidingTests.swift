//
//  ImageServiceTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 07/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
import Caching
import Networking
@testable import BeagleUI

final class ImageServiceTests: XCTestCase {
    
    func test_whenValidURL_returnValidImageData() {
        // Given
        let data = Data()
        let urlRequestDispatchingStub = URLRequestDispatchingStub(resultToReturn: .success(data))
        
        let imageService = ImageDataProviding(
            dispatcher: urlRequestDispatchingStub,
            cacheService: CacheServiceProviderStub(dataResultToReturn: .failure(.couldNotLoadData))
        )
        
        // When
        var resultData: Result<Data, ImageDataProviderError>?
        let fetchImageDataExpectation = expectation(description: "fetchImageDataExpectation")
        let _ = imageService.fetchImageData(from: "https://cdn1-www.dogtime.com/assets/uploads/2011/01/file_23012_beagle-460x290.jpg") { result in
            resultData = result
            fetchImageDataExpectation.fulfill()
        }
        wait(for: [fetchImageDataExpectation], timeout: 2.0)
        
        // Then
        XCTAssertNotNil(resultData, "Expected data to be found, but it was not.")
    }
    
    func test_whenHasCachedData_returnValidImageData() {
        // Given
        let dataToReturn = Data()
        let cacheServiceProviderStub = CacheServiceProviderStub(dataResultToReturn: .success(dataToReturn))
        let urlRequestDispatchingDummy = URLRequestDispatchingDummy()
        
        let sut = ImageDataProviding(
            dispatcher: urlRequestDispatchingDummy,
            cacheService: cacheServiceProviderStub
        )
        
        // When
        let fetchImageDataFromURLExpectation = expectation(description: "fetchImageDataFromURLExpectation")
        var resultReturned: Result<Data, ImageDataProviderError>?
        let _ = sut.fetchImageData(from: "https://cdn1-www.dogtime.com/assets/uploads/2011/01/file_23012_beagle-460x290.jpg") { result in
            resultReturned = result
            fetchImageDataFromURLExpectation.fulfill()
        }
        wait(for: [fetchImageDataFromURLExpectation], timeout: 1.0)
        
        // Then
        guard case let .success(data) = resultReturned else {
            XCTFail("Expected .failure, but got \(String(describing: resultReturned))")
            return
        }
        
        XCTAssertEqual(dataToReturn, data, "Expected \(dataToReturn.debugDescription), but got \(data.debugDescription)")
    }
    
    
    func test_whenRequestFromNetworkAndItReturnsRequestError_itShouldReturnError() {
        // Given
        let cacheServiceProviderStub = CacheServiceProviderStub(dataResultToReturn: .failure(.couldNotLoadData))
        let urlRequestDispatchingStub = URLRequestDispatchingStub(resultToReturn: .failure(.invalidHTTPURLResponse))
        let sut = ImageDataProviding(dispatcher: urlRequestDispatchingStub, cacheService: cacheServiceProviderStub)
        
        // When
        let fetchImageDataExpectation = expectation(description: "fetchImageDataExpectation")
        var resultReturned: Result<Data, ImageDataProviderError>?
        let _ = sut.fetchImageData(from: "www.coisa") { result in
            resultReturned = result
            fetchImageDataExpectation.fulfill()
        }
        wait(for: [fetchImageDataExpectation], timeout: 1.0)
        
        // Then
        guard case let .failure(error) = resultReturned else {
            XCTFail("Expected .failure, but got \(String(describing: resultReturned))")
            return
        }
        
        guard case .request(.invalidHTTPURLResponse) = error else {
            XCTFail("Expected requestBuilder error, but got \(String(describing: error))")
            return
        }
    }
    
    func test_whenRequestFromNetworkAndItReturnsEmptyData_itShouldReturnError() {
        // Given
        let cacheServiceProviderStub = CacheServiceProviderStub(dataResultToReturn: .failure(.couldNotLoadData))
        let urlRequestDispatchingStub = URLRequestDispatchingStub(resultToReturn: .success(nil))
        let sut = ImageDataProviding(dispatcher: urlRequestDispatchingStub, cacheService: cacheServiceProviderStub)
        let expectedError: Result<Data, ImageDataProviderError> = .failure(.emptyData)
        
        // When
        let fetchImageDataExpectation = expectation(description: "fetchImageDataExpectation")
        var resultReturned: Result<Data, ImageDataProviderError>?
        let _ = sut.fetchImageData(from: "www.coisa") { result in
            resultReturned = result
            fetchImageDataExpectation.fulfill()
        }
        wait(for: [fetchImageDataExpectation], timeout: 1.0)
        
        // Then
        XCTAssertEqual(expectedError, resultReturned, "Expected empty data error, but got \(String(describing: resultReturned))")
    }
   
    func test_whenRequestFromNetworkAndItReturnsRequestBuilderFailed_itShouldReturnError() {
        // Given
        let cacheServiceProviderStub = CacheServiceProviderStub(dataResultToReturn: .failure(.couldNotLoadData))
        let urlRequestDispatchingStub = URLRequestDispatchingStub(resultToReturn: .failure(.requestBuilderFailed))
        let sut = ImageDataProviding(dispatcher: urlRequestDispatchingStub, cacheService: cacheServiceProviderStub)
        let expectedError: Result<Data, ImageDataProviderError> = .failure(.request(.requestBuilderFailed))
        
        // When
        let fetchImageDataExpectation = expectation(description: "fetchImageDataExpectation")
        var resultReturned: Result<Data, ImageDataProviderError>?
        let _ = sut.fetchImageData(from: "") { result in
            resultReturned = result
            fetchImageDataExpectation.fulfill()
        }
        wait(for: [fetchImageDataExpectation], timeout: 1.0)
        
        // Then
        XCTAssertEqual(expectedError, resultReturned, "Expected request builder failed error, but got \(String(describing: resultReturned))")
    }

}


// MARK: - Testing Helpers
final class CacheServiceProviderDummy: CacheServiceProvider {
    func save(data: Data, key: String, completion: ((Result<Void, CacheServiceError>) -> Void)?) {}
    func loadData(from key: String, completion: @escaping ((Result<Data, CacheServiceError>) -> Void)) {
        completion(.success(Data()))
    }
    func clear(_ completion: ((Result<Void, CacheServiceError>) -> Void)?) {}
}

final class CacheServiceProviderStub: CacheServiceProvider {
    
    private let dataResultToReturn: Result<Data, CacheServiceError>
    init(dataResultToReturn: Result<Data, CacheServiceError>) {
        self.dataResultToReturn =  dataResultToReturn
    }
    
    func save(data: Data, key: String, completion: ((Result<Void, CacheServiceError>) -> Void)?) {}
    
    func loadData(from key: String, completion: ((Result<Data, CacheServiceError>) -> Void)) {
        completion(dataResultToReturn)
    }
    
    func clear(_ completion: ((Result<Void, CacheServiceError>) -> Void)?) {}
}


extension ImageDataProviderError: Equatable {
    public static func == (lhs: ImageDataProviderError, rhs: ImageDataProviderError) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }
}
