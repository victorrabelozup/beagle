/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import Foundation
import SnapshotTesting
import UIKit

private let imageDiffPrecision: Float = 0.95
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
