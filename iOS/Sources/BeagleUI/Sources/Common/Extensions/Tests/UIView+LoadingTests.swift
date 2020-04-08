/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */


import XCTest
@testable import BeagleUI

final class UIViewLoadingTests: XCTestCase {
    
    func test_showLoading() {
        // Given
        let view = UIView()
        
        // When
        view.showLoading()
        
        // Then
        XCTAssertNotNil(view.viewWithTag(LoadingView.tag), "The view should contain a `LoadingView`.")
    }
    
    func test_hideLoading() {
        // Given
        let view = UIView()
        view.showLoading()
        let theViewHadALoadingView = view.viewWithTag(LoadingView.tag) != nil
        
        // When
        let hideLoadingExpectation = expectation(description: "hideLoadingExpectation")
        view.hideLoading {
            hideLoadingExpectation.fulfill()
        }
        wait(for: [hideLoadingExpectation], timeout: 1.0)
        
        // Then
        XCTAssertTrue(theViewHadALoadingView, "The view had a `LoadingView` that needed to be hidden.")
        XCTAssertNil(view.viewWithTag(LoadingView.tag), "The view should not contain a `LoadingView`.")
    }
    
}
