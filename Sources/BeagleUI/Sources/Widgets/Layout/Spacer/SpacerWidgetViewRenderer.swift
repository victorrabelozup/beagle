//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

final class SpacerWidgetViewRenderer: ViewRendering<Spacer> {
    
    override func buildView(context: BeagleContext) -> UIView {
        
        let flex = Flex(
            size: Flex.Size(
                width: UnitValue(value: widget.size, type: .real),
                height: UnitValue(value: widget.size, type: .real)
            )
        )
        
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.isAccessibilityElement = false
        view.backgroundColor = .clear
        
        self.flex.setupFlex(flex, for: view)
        
        return view
    }
    
}
