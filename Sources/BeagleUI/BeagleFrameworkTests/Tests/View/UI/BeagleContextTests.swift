//
//  BeagleContextTests.swift
//  BeagleFrameworkTests
//
//  Created by Lucas Araújo on 13/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class BeagleContextTests: XCTestCase {

    func test_registerAction_shouldAddGestureRecognizer() {
        // Given
        let screenMock = ServerDrivenScreenMock()
        let sut = BeagleScreenViewController(
            screenType: .declarative(screenMock),
            flexConfigurator: FlexViewConfiguratorDummy(),
            viewBuilder: BeagleViewBuilderDummy(),
            serverDrivenScreenLoader: ServerDrivenScreenLoaderDummy()
        )
        let view = UILabel()
        let action = Navigate(type: .popView)
        
        // When
        sut.register(action: action, inView: view)
        
        // Then
        XCTAssertEqual(1, view.gestureRecognizers?.count)
        XCTAssertTrue(view.isUserInteractionEnabled)
    }
    
}
