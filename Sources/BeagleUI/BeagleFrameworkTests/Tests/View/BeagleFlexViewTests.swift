//
//  BeagleFlexViewTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 14/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class BeagleFlexViewTests: XCTestCase {

    func test_init_shouldSetupTheDependenciesProperly() {
        // Given
        let sut = BeagleFlexView(flex: Flex())
        let mirror = Mirror(reflecting: sut)
        
        // When
        let flex = mirror.firstChild(of: Flex.self, in: "flex")
        let flexConfigurator = mirror.firstChild(of: FlexViewConfigurator.self)
        
        // Then
        XCTAssertNotNil(flex, "Expected a valid instance of type `Flex`, but got nil.")
        XCTAssertNotNil(flexConfigurator, "Expected a valid instance of type `FlexViewConfigurator`, but got nil.")
    }
    
    func test_addChild_shouldAddASubviewAndApplyFlex() {
        // Given
        let configuratorSpy = FlexViewConfiguratorSpy()
        let sut = BeagleFlexView(flex: Flex(), flexConfigurator: configuratorSpy)
        let child = UIButton()
        
        // When
        sut.addChildView(child, flex: Flex())
        
        // Then
        XCTAssertTrue(configuratorSpy.applyFlexCalled)
        XCTAssertEqual(child, configuratorSpy.viewPassed, "Expected \(String(describing: child)), but got \(String(describing: configuratorSpy.viewPassed)).")
        XCTAssertEqual(1, sut.subviews.count, "The subviews should be == 1.")
    }
    
    func test_removeChild_shouldRemoveFromSuperview() {
        // Given
        let sut = BeagleFlexView(flex: Flex())
        let child = UIButtonSpy()
        sut.addChildView(child, flex: Flex())
        XCTAssertEqual(1, sut.subviews.count, "The subviews should be == 1.")
        
        // When
        sut.removeChild(child)
        
        // Then
        XCTAssertTrue(child.removeFromSuperviewCalled, "`removeFromSuperview` should have been called.")
        XCTAssertEqual(0, sut.subviews.count, "The subviews should be == 0.")
    }

}

// MARK: - Testing Helpers

final class FlexViewConfiguratorSpy: FlexViewConfiguratorProtocol {
    
    private(set) var applyFlexCalled = false
    private(set) var flexPassed: Flex?
    private(set) var viewPassed: UIView?
    func applyFlex(_ flex: Flex, to view: UIView) {
        applyFlexCalled = true
        flexPassed = flex
        viewPassed = view
    }
    
}

private final class UIButtonSpy: UIButton {
    
    private(set) var removeFromSuperviewCalled = false
    override func removeFromSuperview() {
        removeFromSuperviewCalled = true
        super.removeFromSuperview()
    }
    
}
