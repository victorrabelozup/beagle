//
//  Copyright © 21/11/19 Zup IT. All rights reserved.
//

import Foundation
import UIKit

class PageViewRender: WidgetViewRenderer<PageView> {

    override func buildView(context: BeagleContext) -> UIView {
        let pages = widget.pages.map {
            BeagleScreenViewController(screenType: .declarative($0))
        }

        let indicator = pageIndicatorView(widget.pageIndicator, context: context)

        let view = PageViewUIComponent(
            model: .init(pages: pages),
            indicatorView: indicator
        )

        flexViewConfigurator.applyYogaLayout(to: view, preservingOrigin: true)
        flexViewConfigurator.setupFlex(Flex(), for: view)
        return view
    }

    private func pageIndicatorView(
        _ customIndicator: PageIndicator?,
        context: BeagleContext
    ) -> PageIndicatorUIView {
        let defaultView = DefaultPageIndicatorUIComponent.self
        guard let indicator = customIndicator else {
            return defaultView.init()
        }

        let render = rendererProvider.buildRenderer(for: indicator)
        let view = render.buildView(context: context) as? PageIndicatorUIView
            ?? defaultView.init()
        return view
    }
}
