/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

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
            size: Size(
                width: UnitValue(value: size, type: .real),
                height: UnitValue(value: size, type: .real)
            )
        )
        
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.isAccessibilityElement = false
        view.backgroundColor = .clear

        view.flex.setup(flex)
        return view
    }
}
