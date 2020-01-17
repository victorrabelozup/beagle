//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit
import YogaKit

final class ContainerWidgetViewRenderer: ViewRendering<Container> {
    
    // MARK: - Public Functions
    
    override func buildView(context: BeagleContext) -> UIView {
        let view = UIView()
        
        if let header = widget.header {
            let headerView = dependencies.rendererProvider
                .buildRenderer(for: header, dependencies: dependencies)
                .buildView(context: context)
            view.addSubview(headerView)
            dependencies.flex.enableYoga(true, for: headerView)
        }
        
        let contentView = buildContentView(context: context)
        view.addSubview(contentView)
        
        if let footer = widget.footer {
            let footerView = dependencies.rendererProvider
                .buildRenderer(for: footer, dependencies: dependencies)
                .buildView(context: context)
            view.addSubview(footerView)
            dependencies.flex.enableYoga(true, for: footerView)
        }
        return view
    }
    
    // MARK: - Private Functions
    
    private func buildContentView(context: BeagleContext) -> UIView {
        let flex = Flex(grow: 1)
        let contentView = dependencies.rendererProvider
            .buildRenderer(for: widget.content, dependencies: dependencies)
            .buildView(context: context)
        dependencies.flex.setupFlex(flex, for: contentView)
        return contentView
    }
}
