/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import XCTest
@testable import BeagleUI

final class FormSubmitTests: XCTestCase {
    
    func test_initWithChild_shouldReturnValidFormSubmit() {
        // Given / When
        let sut = FormSubmit(child:
            Text("Text")
        )
        // Then
        XCTAssert(sut.child is Text)
    }
    
    func test_toView_shouldReturnTheExpectedView() {
        // Given
        let formSubmit = FormSubmit(child: ComponentDummy())
                
        // When
        let view = formSubmit.toView(context: BeagleContextDummy(), dependencies: BeagleScreenDependencies())
        
        // Then
        XCTAssertTrue(view.subviews.first?.beagleFormElement is FormSubmit)
    }
    
}
