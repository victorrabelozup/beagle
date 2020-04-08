/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import XCTest
import SnapshotTesting
@testable import BeagleUI
// swiftlint:disable implicitly_unwrapped_optional
class AnalyticsTests: XCTestCase {

    private let category = "some category"
    private let anotherCategory = "another category"
    private let label = "label"
    private let value = "value"
    private let nameOfScreen = "name of screen"
    private var justClick: AnalyticsClick!
    private var clickWithDescription: AnalyticsClick!
    
    override func setUp() {
        super.setUp()
        self.justClick = AnalyticsClick(category: category)
        self.clickWithDescription = AnalyticsClick(category: anotherCategory, label: label, value: value)
    }
    
    func testBuildOfAnalyticsObjects() {
        //given //when
        let screen = AnalyticsScreen(screenName: nameOfScreen)
        
        //then
        XCTAssert(
            clickWithDescription.category == anotherCategory &&
            clickWithDescription.label == label &&
            clickWithDescription.value == value,
            "attributes are not being created correctly")
        
        XCTAssert(justClick.category == category, "attributes are not being created correctly")
        
        XCTAssert(screen.screenName == nameOfScreen, "attributes are not being created correctly")
    }
    
    func testBuildOfAnalyticsGestureRecognizer() {
        //given //when
        let gestureRecognizer = AnalyticsGestureRecognizer(event: justClick, target: nil, selector: nil)
        
        //then
        XCTAssert(gestureRecognizer.click == justClick, "click object should be the same")
    }
    
    func testTrackEventOnClick() {
        //given
        let analyticsExecutor = AnalyticsExecutorSpy()
        
        //when
        analyticsExecutor.trackEventOnClick(clickWithDescription)
        
        //then
        XCTAssert(analyticsExecutor.analyticsClickEvent == clickWithDescription, "click event not called")
    }
    
    func testTrackScreenEvents() {
        //given
        let screen = AnalyticsScreen(screenName: "name of screen")
        let analyticsExecutor = AnalyticsExecutorSpy()
        
        //when
        analyticsExecutor.trackEventOnScreenAppeared(screen)
        analyticsExecutor.trackEventOnScreenDisappeared(screen)
        
        //then
        XCTAssert(
            analyticsExecutor.analyticsScreenAppearedEvent == screen &&
            analyticsExecutor.didTrackEventOnScreenAppeared,
            "trackEventOnScreenAppeared not called")
        XCTAssert(
            analyticsExecutor.analyticsScreenDisappearedEvent == screen &&
            analyticsExecutor.didTrackEventOnScreenDisappeared,
            "trackEventOnScreenDisappeared not called")
    }
    
    func testIfDecodingIsSuccessfullForScreenEvent() throws {
        let component: ScreenComponent = try componentFromJsonFile(fileName: "screenAnalyticsComponent")
        assertSnapshot(matching: component, as: .dump)
    }
    
    func testIfDecodingIsSuccessfullForClickEvent() throws {
        let component: Button = try componentFromJsonFile(fileName: "buttonAnalyticsComponent")
        assertSnapshot(matching: component, as: .dump)
    }
}

final class AnalyticsExecutorSpy: Analytics {
    
    private(set) var didTrackEventOnClick = false
    private(set) var didTrackEventOnScreenDisappeared = false
    private(set) var didTrackEventOnScreenAppeared = false

    private(set) var analyticsScreenAppearedEvent: AnalyticsScreen?
    private(set) var analyticsScreenDisappearedEvent: AnalyticsScreen?
    private(set) var analyticsClickEvent: AnalyticsClick?
    
    func trackEventOnScreenAppeared(_ event: AnalyticsScreen) {
        didTrackEventOnScreenAppeared = true
        analyticsScreenAppearedEvent = event
    }
    
    func trackEventOnScreenDisappeared(_ event: AnalyticsScreen) {
        didTrackEventOnScreenDisappeared = true
        analyticsScreenDisappearedEvent = event
    }
    
    func trackEventOnClick(_ event: AnalyticsClick) {
        didTrackEventOnClick = true
        analyticsClickEvent = event
    }
}

extension AnalyticsClick: Equatable {
    public static func == (lhs: AnalyticsClick, rhs: AnalyticsClick) -> Bool {
        return lhs.category == rhs.category &&
            lhs.label == rhs.label &&
            lhs.value == rhs.value
    }
}

extension AnalyticsScreen: Equatable {
    public static func == (lhs: AnalyticsScreen, rhs: AnalyticsScreen) -> Bool {
        return lhs.screenName == rhs.screenName
    }
}
