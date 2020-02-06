//
//  Copyright © 18/12/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI
import SnapshotTesting

final class BeaglePrefetchHelperTests: XCTestCase {

    func testPrefetchAndDequeue() {
        let sut = BeaglePreFetchHelper()
        let url = "url-test"

        sut.prefetchWidget(path: url)
        let result = sut.dequeueWidget(path: url)

        switch result.viewModel.screenType {
        case .remote(let path):
            XCTAssert(path == url)
        case .declarative:
            XCTFail("Not the right type")
        }
    }
    
    func testPrefetchTheSameScreenTwice() {
        let sut = BeaglePreFetchHelper()
        let url = "url-test"

        sut.prefetchWidget(path: url)
        let result1 = sut.dequeueWidget(path: url)
        sut.prefetchWidget(path: url)
        let result2 = sut.dequeueWidget(path: url)
        
        XCTAssert(result1 === result2)
    }

    func testNavigationIsPrefetchable() {
        let path = "path"
        let data = ["data": "value"]

        let actions: [Navigate] = [
            .openDeepLink(.init(path: path)),
            .openDeepLink(.init(path: path, data: nil)),
            .openDeepLink(.init(path: path, data: data)),

            .addView(path),
            .presentView(path),
            .swapView(path),
            .popView,
            .popToView(path),
            .finishView
        ]

        let bools = actions.map { $0.prefechableData }

        let result: String = zip(actions, bools).reduce("") { partial, zip in
            "\(partial)  \(zip.0)  -->  \(descriptionWithoutOptional(zip.1)) \n\n"
        }
        assertSnapshot(matching: result, as: .description)
    }

}
