//
//  Copyright © 03/01/20 Zup IT. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import BeagleUI

final class TextTests: XCTestCase {
    
    private lazy var theme = AppTheme(styles: [
        "test.text.style": textStyle
    ])
    
    private func textStyle() -> (UILabel?) -> Void {
        BeagleStyle.label(font: .boldSystemFont(ofSize: 20), color: .blue)
            <> BeagleStyle.backgroundColor(withColor: .black)
    }
    
    override func setUp() {
        super.setUp()
        let dependencies = BeagleDependencies()
        dependencies.theme = theme
        Beagle.dependencies = dependencies
    }
    
    override func tearDown() {
        Beagle.dependencies = BeagleDependencies()
        super.tearDown()
    }
    
    func test_whenDecodingJson_shouldReturnAText() throws {
        let widget: Text = try widgetFromJsonFile(fileName: "TextWidget")
        assertSnapshot(matching: widget, as: .dump)
    }
    
    func test_renderTextWidget() throws {
        let widget: Text = try widgetFromJsonFile(fileName: "TextWidget")
        let screen = BeagleScreenViewController(
            viewModel: .init(screenType: .declarative(widget))
        )
        assertSnapshot(matching: screen, as: .image)
    }

}
