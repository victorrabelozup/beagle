//
//  Copyright © 04/12/19 Zup IT. All rights reserved.
//

import Foundation
@testable import BeagleUI
import XCTest
import SnapshotTesting

class CustomPageIndicatorTest: XCTestCase {

    private let typeName = "CustomPageIndicator"

    private lazy var decoder: WidgetDecoder = {
        let decoder = WidgetDecoder()
        decoder.register(CustomPageIndicatorEntity.self, for: typeName)
        return decoder
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

    private lazy var provider: WidgetRendererProviding = {
        let renderer = WidgetRendererProviding()
        renderer.providers.append(customRendererProvider)
        return renderer
    }()

    private lazy var dependencies = RendererDependenciesContainer(rendererProvider: provider)

    private lazy var builder = BeagleViewBuilding(dependencies: dependencies)

    func test_indicator_decoder() throws {
        let widget: CustomPageIndicator = try widgetFromJsonFile(
            fileName: typeName,
            decoder: decoder
        )
        assertSnapshot(matching: widget, as: .dump)
    }

    func test_indicator_render() {
        let view = builder.buildFromRootWidget(indicator, context: BeagleContextDummy())
        view.frame = .init(x: 0, y: 0, width: 200, height: 30)

        assertSnapshot(matching: view, as: .image)
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

        let screen = BeagleScreenViewController(
            screenType: .declarative(widget),
            viewBuilder: builder
        )

        assertSnapshot(matching: screen, as: .image)
    }
}
