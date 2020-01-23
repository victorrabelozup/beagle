//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

final class ScrollViewWidgetViewRenderer: ViewRendering<ScrollView> {
    
    // MARK: - Public Functions
    
    override func buildView(context: BeagleContext) -> UIView {
        let scrollView = buildScrollView(context: context)
        return scrollView
    }
    
    // MARK: - Private Functions
    
    private func buildScrollView(context: BeagleContext) -> UIScrollView {
        
        let scrollView = BeagleContainerScrollView()
        let contentView = UIView()
        
        widget.children.forEach {
            let childView = dependencies.rendererProvider
                .buildRenderer(for: $0, dependencies: dependencies)
                .buildView(context: context)
            contentView.addSubview(childView)
            dependencies.flex.enableYoga(true, for: childView)
        }
        scrollView.addSubview(contentView)
        scrollView.applyAppearance(widget.appearance)
        
        let flexContent = Flex(grow: 0, shrink: 0)
        dependencies.flex.setupFlex(flexContent, for: contentView)
        
        return scrollView
    }
}

final class BeagleContainerScrollView: UIScrollView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if let contentView = subviews.first {
            contentSize = contentView.frame.size
        }
    }
}
