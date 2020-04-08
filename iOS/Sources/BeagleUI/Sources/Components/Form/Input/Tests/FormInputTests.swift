/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import XCTest
@testable import BeagleUI

final class FormInputTests: XCTestCase {
    
    func test_initWithChild_shouldReturnValidFormInput() {
        // Given / When
        let sut = FormInput(name: "name", child:
            Text("Text")
        )
        // Then
        XCTAssert(sut.child is Text)
    }
    
    func test_buildView_shouldReturnTheExpectedView() {
        // Given
        let formInput = FormInput(name: "username", child: ComponentDummy())
        
        // When
        let formInputView = formInput.toView(context: BeagleContextDummy(), dependencies: BeagleScreenDependencies())
        
        // Then
        XCTAssertTrue(formInputView.beagleFormElement is FormInput)
    }
    
    func test_formInputHidenView_ShouldReturnExpectedValue() {
        // Given
        let name = "id"
        let value = "123123"
        let formInputHiden = FormInputHidden(name: name, value: value)
        
        // When
        let view = formInputHiden.toView(context: BeagleContextDummy(), dependencies: BeagleScreenDependencies()) as? InputValue
        
        // Then
        XCTAssert(view?.getValue() is String)
        XCTAssert(name == formInputHiden.name)
        XCTAssert(value == view?.getValue() as? String)
    }
}
