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

        sut.prefetchComponent(newPath: .init(path: url, shouldPrefetch: true))
        let result = sut.dequeueComponent(path: url)

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

        sut.prefetchComponent(newPath: .init(path: url, shouldPrefetch: true))
        let result1 = sut.dequeueComponent(path: url)
        sut.prefetchComponent(newPath: .init(path: url, shouldPrefetch: true))
        let result2 = sut.dequeueComponent(path: url)
        
        XCTAssert(result1 === result2)
    }

    func testNavigationIsPrefetchable() {
        let path = "path"
        let data = ["data": "value"]

        let actions: [Navigate] = [
            .openDeepLink(.init(path: path, data: nil)),
            .openDeepLink(.init(path: path, data: data)),

            .addView(.init(path: path, shouldPrefetch: true)),
            .addView(.init(path: path, shouldPrefetch: false)),
            
            .presentView(.init(path: path, shouldPrefetch: true)),
            .presentView(.init(path: path, shouldPrefetch: false)),
            
            .swapView(.init(path: path, shouldPrefetch: true)),
            .swapView(.init(path: path, shouldPrefetch: false)),
            
            .popView,
            .popToView(path),
            .finishView
        ]

        let bools = actions.map { $0.newPath }

        let result: String = zip(actions, bools).reduce("") { partial, zip in
            "\(partial)  \(zip.0)  -->  \(descriptionWithoutOptional(zip.1)) \n\n"
        }
        assertSnapshot(matching: result, as: .description)
    }

}
