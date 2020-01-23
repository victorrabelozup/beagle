//
//  Copyright © 04/12/19 Zup IT. All rights reserved.
//

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
            CustomPageIndicatorEntity.self,
            for: CustomPageIndicatorTest.typeName
        )
    }
    
    override func tearDown() {
        Beagle.dependencies = BeagleDependencies()
        super.tearDown()
    }

    private lazy var decoder: WidgetDecoding = {
        Beagle.dependencies.decoder
    }()

    let indicator = CustomPageIndicator(
        selectedColor: "selectedColor",
        defaultColor: "defaultColor"
    )

    private lazy var customRendererProvider: CustomWidgetsRendererProviding = {
        let custom = CustomWidgetsRendererProviding()
        custom.registerRenderer(CustomPageIndicatorRenderer.self, for: CustomPageIndicator.self)
        return custom
    }()

    private lazy var provider: RendererProviding = {
        let renderer = RendererProviding()
        renderer.providers.append(customRendererProvider)
        return renderer
    }()

    private lazy var dependencies = BeagleScreenDependencies(
        rendererProvider: provider
    )

    func test_indicator_decoder() throws {
        let widget: CustomPageIndicator = try widgetFromJsonFile(
            fileName: CustomPageIndicatorTest.typeName,
            decoder: decoder
        )
        assertSnapshot(matching: widget, as: .dump)
    }

    func test_indicator_render() {
        let view = indicator.toView(context: BeagleContextDummy(), dependencies: dependencies)
        assertSnapshotImage(view, size: .init(width: 200, height: 30))
    }

    func test_pageViewWithCustomIndicator_decoder() throws {
        let widget: PageView = try widgetFromJsonFile(
            fileName: "PageViewWithCustomIndicator",
            decoder: decoder
        )
        assertSnapshot(matching: widget.pageIndicator, as: .dump)
    }

    func test_pageViewWithCustomIndicator_render() {
        let page = Text("Page")

        let widget = PageView(
            pages: Array(repeating: page, count: 3),
            pageIndicator: indicator
        )

        let screen = BeagleScreenViewController(viewModel: .init(
            screenType: .declarative(widget.toScreen()),
            dependencies: dependencies
        ))

        assertSnapshotImage(screen)
    }
}
