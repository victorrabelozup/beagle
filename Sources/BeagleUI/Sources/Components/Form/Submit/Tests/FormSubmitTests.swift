//
//  Copyright © 2019 Zup IT. All rights reserved.
//

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
        let view = formSubmit.toView(context: BeagleContextDummy(), dependencies: RendererDependenciesContainer())
        
        // Then
        XCTAssertTrue(view.subviews.first?.beagleFormElement is FormSubmit)
    }
    
}
