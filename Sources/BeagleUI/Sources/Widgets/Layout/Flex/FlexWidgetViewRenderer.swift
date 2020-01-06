//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit
import YogaKit

final class FlexWidgetViewRenderer: ViewRendering<FlexWidget> {
    
    // MARK: - Public Functions
    
    override func buildView(context: BeagleContext) -> UIView {
        
        let containerView = UIView()
        
        widget.children.forEach {
            let childView = self.rendererProvider
                .buildRenderer(for: $0, dependencies: dependencies)
                .buildView(context: context)
            containerView.addSubview(childView)
            self.flex.enableYoga(true, for: childView)
        }
        containerView.applyAppearance(widget.appearance)
        
        self.flex.setupFlex(widget.flex, for: containerView)
        
        return containerView
    }
    
}
