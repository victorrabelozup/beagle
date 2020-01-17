//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

final class FlexSingleWidgetViewRenderer: ViewRendering<FlexSingleWidget> {
    
    // MARK: - Public Functions
    
    override func buildView(context: BeagleContext) -> UIView {
        let child = widget.child
        let childRenderer = dependencies.rendererProvider.buildRenderer(for: child, dependencies: dependencies)
        let childView = childRenderer.buildView(context: context)
        
        let view = UIView()
        view.addSubview(childView)
        view.applyAppearance(widget.appearance)
        
        dependencies.flex.enableYoga(true, for: childView)
        dependencies.flex.setupFlex(widget.flex, for: view)
        
        return view
    }
}
