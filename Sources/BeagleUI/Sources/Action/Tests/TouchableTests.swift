//
//  Copyright © 04/11/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI
import SnapshotTesting

final class TouchableTests: XCTestCase {
    
    func testInitFromDecoder() throws {
        let component: Touchable = try componentFromJsonFile(fileName: "TouchableDecoderTest")
        assertSnapshot(matching: component, as: .dump)
    }

    func testTouchableView() throws {
        let touchable = Touchable(action: Navigate.popView, child: Text("Touchable"))
        let view = touchable.toView(context: BeagleContextDummy(), dependencies: BeagleDependencies())

        assertSnapshotImage(view, size: CGSize(width: 100, height: 80))
    }
}
