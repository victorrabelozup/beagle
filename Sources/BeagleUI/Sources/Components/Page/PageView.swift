//
//  Copyright © 21/11/19 Zup IT. All rights reserved.
//

import UIKit

public struct PageView: ServerDrivenComponent {

    public let pages: [ServerDrivenComponent]
    public let pageIndicator: PageIndicator?

    public init(
        pages: [ServerDrivenComponent],
        pageIndicator: PageIndicator?
    ) {
        self.pages = pages
        self.pageIndicator = pageIndicator
    }
}

extension PageView: Renderable {
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let pagesControllers = pages.map {
            BeagleScreenViewController(
                viewModel: .init(screenType: .declarative($0.toScreen()))
            )
        }

        var indicatorView: PageIndicatorUIView?
        if let indicator = pageIndicator {
            indicatorView = indicator.toView(context: context, dependencies: dependencies) as? PageIndicatorUIView
        }

        let view = PageViewUIComponent(
            model: .init(pages: pagesControllers),
            indicatorView: indicatorView
        )
        
        view.flex.setupFlex(Flex(grow: 1.0))
        return view
    }
}

public protocol PageIndicator: ServerDrivenComponent {}
