//
//  Copyright © 08/10/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ButtonTests: XCTestCase {

    private let dependencies = RendererDependenciesContainer()
    
    func test_toView_shouldSetRightButtonTitle() throws {
        //Given
        let buttonTitle = "title"
        let widget = Button(text: buttonTitle)
        let context = BeagleContextDummy()
        
        //When        
        guard let button = widget.toView(context: context, dependencies: dependencies) as? UIButton else {
            XCTFail("Build View not returning UIButton")
            return
        }
        
        // Then
        XCTAssertEqual(button.titleLabel?.text, buttonTitle)
    }
}
