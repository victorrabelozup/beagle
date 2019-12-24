//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

final class FlexSingleWidgetViewRenderer: ViewRendering<FlexSingleWidget> {
    
    // MARK: - Public Functions
    
    override func buildView(context: BeagleContext) -> UIView {
        
        let child = widget.child
        let childRenderer = self.rendererProvider.buildRenderer(for: child, dependencies: dependencies)
        let childView = childRenderer.buildView(context: context)
        
        let view = UIView()
        view.addSubview(childView)
        
        self.flex.enableYoga(true, for: childView)
        self.flex.setupFlex(widget.flex, for: view)
        
        return view
    }
}
