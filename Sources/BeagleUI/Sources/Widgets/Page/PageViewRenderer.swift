//
//  Copyright © 21/11/19 Zup IT. All rights reserved.
//

import Foundation
import UIKit

class PageViewRender: ViewRendering<PageView> {

    override func buildView(
        context: BeagleContext
    ) -> UIView {
        let pages = widget.pages.map {
            BeagleScreenViewController(
                viewModel: .init(screenType: .declarative($0.toScreen()))
            )
        }

        var indicatorView: PageIndicatorUIView?
        if let indicator = widget.pageIndicator {
            indicatorView = try? buildPageIndicatorView(for: indicator, context: context)
        }

        let view = PageViewUIComponent(
            model: .init(pages: pages),
            indicatorView: indicatorView
        )

        return view
    }

    private func buildPageIndicatorView(
        for indicator: PageIndicator,
        context: BeagleContext
    ) throws -> PageIndicatorUIView {
        let render = dependencies.rendererProvider.buildRenderer(for: indicator, dependencies: dependencies)
        let view = render.buildView(context: context)

        guard let indicatorView = view as? PageIndicatorUIView else {
            throw ViewRendererError.couldNotCastWidgetToType(String(describing: PageIndicatorUIView.self))
        }

        return indicatorView
    }
}
