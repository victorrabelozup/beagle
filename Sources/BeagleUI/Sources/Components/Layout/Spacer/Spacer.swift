//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public struct Spacer: ServerDrivenComponent {
    
    // MARK: - Public Properties
    
    public let size: Double
    
    // MARK: - Initialization
    
    public init(_ size: Double) {
        self.size = size
    }
    
}

extension Spacer: Renderable {
    
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let flex = Flex(
            size: Flex.Size(
                width: UnitValue(value: size, type: .real),
                height: UnitValue(value: size, type: .real)
            )
        )
        
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.isAccessibilityElement = false
        view.backgroundColor = .clear

        view.flex.setupFlex(flex)
        return view
    }
}
