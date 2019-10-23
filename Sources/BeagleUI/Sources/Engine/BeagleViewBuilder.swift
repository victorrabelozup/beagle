//
//  BeagleViewBuilder.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 07/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public protocol BeagleViewBuilder {
    func buildFromRootWidget(_ widget: Widget) -> UIView
}

public final class BeagleViewBuilding: BeagleViewBuilder {
    
    // MARK: - Dependencies
    
    private let rendererProvider: WidgetRendererProvider
    private let flexConfigurator: FlexViewConfiguratorProtocol
    
    // MARK: - Initialization
    
    public convenience init() {
        self.init(rendererProvider: nil)
    }
    
    init(
        rendererProvider: WidgetRendererProvider? = nil,
        flexConfigurator: FlexViewConfiguratorProtocol? = nil
    ) {
        self.rendererProvider = rendererProvider ?? WidgetRendererProviding()
        self.flexConfigurator = flexConfigurator ?? FlexViewConfigurator()
    }
    
    // MARK: - Public Functions
    
    public func buildFromRootWidget(_ widget: Widget) -> UIView {
        let renderer = rendererProvider.buildRenderer(for: widget)
        let view = renderer.buildView()
        flexConfigurator.applyYogaLayout(to: view, preservingOrigin: true)
        return view
    }
    
}
