/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import UIKit

public struct PageView: ServerDrivenComponent {

    public let pages: [ServerDrivenComponent]
    public let pageIndicator: PageIndicatorComponent?

    public init(
        pages: [ServerDrivenComponent],
        pageIndicator: PageIndicatorComponent?
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
        
        view.flex.setup(Flex(grow: 1.0))
        return view
    }
}

extension PageView: Decodable {
    enum CodingKeys: String, CodingKey {
        case pages
        case pageIndicator
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.pages = try container.decode(forKey: .pages)
        let pageIndicator = try container.decodeIfPresent(AnyDecodableContainer.self, forKey: .pageIndicator)
        self.pageIndicator = (pageIndicator?.content as? PageIndicatorComponent)
    }
}

public protocol PageIndicatorComponent: ServerDrivenComponent {}
