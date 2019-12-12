//
//  BeagleViewBuilder.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 07/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public protocol BeagleViewBuilder {
    func buildFromRootWidget(_ widget: Widget, context: BeagleContext) -> UIView
}

public final class BeagleViewBuilding: BeagleViewBuilder {

    // MARK: - Dependencies
    
    private let dependencies: RendererDependencies
    
    // MARK: - Initialization
    
    public convenience init() {
        self.init(dependencies: nil)
    }
    
    init(
        dependencies: RendererDependencies? = nil
    ) {
        self.dependencies = dependencies ?? BeagleEnvironment.shared
    }
    
    // MARK: - Public Functions
    
    public func buildFromRootWidget(_ widget: Widget, context: BeagleContext) -> UIView {
        return dependencies.rendererProvider
            .buildRenderer(for: widget, dependencies: dependencies)
            .buildView(context: context)
    }
    
}
