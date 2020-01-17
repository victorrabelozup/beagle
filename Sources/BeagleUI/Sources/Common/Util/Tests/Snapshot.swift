//
//  Copyright © 10/01/20 Zup IT. All rights reserved.
//

import Foundation
import SnapshotTesting
import UIKit

private let imageDiffPrecision: Float = 0.9
private let imageSize = CGSize(width: 300, height: 649) // 80% of iPhone X size

func assertSnapshotImage(
    _ value: UIView,
    size: CGSize? = nil,
    record: Bool = false,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) {
    let strategy: Snapshotting<UIView, UIImage> = Snapshotting.image(
        precision: imageDiffPrecision,
        size: size ?? imageSize
    )

    assertSnapshot(
        matching: value,
        as: strategy,
        record: record,
        file: file,
        testName: testName,
        line: line
    )
}

func assertSnapshotImage(
    _ value: UIViewController,
    size: CGSize? = nil,
    record: Bool = false,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) {
    let strategy: Snapshotting<UIViewController, UIImage> = Snapshotting.image(
        precision: imageDiffPrecision,
        size: size ?? imageSize
    )

    assertSnapshot(
        matching: value,
        as: strategy,
        record: record,
        file: file,
        testName: testName,
        line: line
    )
}
