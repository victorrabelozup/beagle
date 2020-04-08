/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import Foundation
@testable import BeagleUI
import XCTest
import SnapshotTesting

class CustomPageIndicatorTest: XCTestCase {

    private static let typeName = "CustomPageIndicator"
    
    override func setUp() {
        super.setUp()
        Beagle.dependencies = BeagleDependencies()
        Beagle.dependencies.decoder.register(
            CustomPageIndicator.self,
            for: CustomPageIndicatorTest.typeName
        )
    }
    
    override func tearDown() {
        Beagle.dependencies = BeagleDependencies()
        super.tearDown()
    }

    private lazy var decoder: ComponentDecoding = {
        Beagle.dependencies.decoder
    }()

    let indicator = CustomPageIndicator(
        selectedColor: "selectedColor",
        defaultColor: "defaultColor"
    )

    private lazy var dependencies = BeagleScreenDependencies()

    func test_indicator_decoder() throws {
        let component: CustomPageIndicator = try componentFromJsonFile(
            fileName: CustomPageIndicatorTest.typeName,
            decoder: decoder
        )
        assertSnapshot(matching: component, as: .dump)
    }

    func test_indicator_render() {
        let view = indicator.toView(context: BeagleContextDummy(), dependencies: dependencies)
        assertSnapshotImage(view, size: .init(width: 200, height: 30))
    }

    func test_pageViewWithCustomIndicator_decoder() throws {
        let component: PageView = try componentFromJsonFile(
            fileName: "PageViewWithCustomIndicator",
            decoder: decoder
        )
        assertSnapshot(matching: component.pageIndicator, as: .dump)
    }

    func test_pageViewWithCustomIndicator_render() {
        let page = Text("Page")

        let component = PageView(
            pages: Array(repeating: page, count: 3),
            pageIndicator: indicator
        )

        let screen = BeagleScreenViewController(viewModel: .init(
            screenType: .declarative(component.toScreen()),
            dependencies: dependencies
        ))

        assertSnapshotImage(screen)
    }
}
