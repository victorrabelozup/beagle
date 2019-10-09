//
//  BeagleFlexView.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 09/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit
import YogaKit

public final class BeagleFlexView: UIView {
    
    // MARK: - Dependencies
    
    public private(set) var flex: Flex
    private let flexConfigurator: FlexViewConfiguratorProtocol
    
    // MARK: - Intialization
    
    init(flex: Flex, flexConfigurator: FlexViewConfiguratorProtocol = FlexViewConfigurator()) {
        self.flex = flex
        self.flexConfigurator = flexConfigurator
        super.init(frame: UIScreen.main.bounds)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setup() {
        flexConfigurator.applyFlex(flex, to: self)
    }
    
    // MARK: - Public Functions
    
    public func addChildView(_ child: UIView, flex: Flex) {
        flexConfigurator.applyFlex(flex, to: child)
        addSubview(child)
    }
    
    public func removeChild(_ child: UIView) {
        child.removeFromSuperview()
    }
    
}
