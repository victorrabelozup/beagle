//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

public struct ScrollView: AppearanceComponent {
    
    // MARK: - Public Properties
    
    public let children: [ServerDrivenComponent]
    public let appearance: Appearance?
    
    // MARK: - Initialization

    public init(
        children: [ServerDrivenComponent],
        appearance: Appearance? = nil
    ) {
        self.children = children
        self.appearance = appearance
    }
    
}

extension ScrollView: Renderable {
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let scrollView = BeagleContainerScrollView()
        let contentView = UIView()
        
        children.forEach {
            let childView = $0.toView(context: context, dependencies: dependencies)
            contentView.addSubview(childView)
            childView.flex.isEnabled = true
        }
        scrollView.addSubview(contentView)
        scrollView.applyAppearance(appearance)
        scrollView.flex.setupFlex(Flex(grow: 1))
        
        let flexContent = Flex(grow: 0, shrink: 0)
        contentView.flex.setupFlex(flexContent)
        
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
