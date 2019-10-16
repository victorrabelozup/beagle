//
//  BeagleViewBuilder.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 07/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

protocol BeagleViewBuilder {
    func buildFromRootWidget(_ widget: Widget) -> UIView
}

final class BeagleViewBuilding: BeagleViewBuilder {
    
    // MARK: - Dependencies
    
    private let rendererProvider: WidgetRendererProvider
    
    // MARK: - Initialization
    
    init(rendererProvider: WidgetRendererProvider = WidgetRendererProviding()) {
        self.rendererProvider = rendererProvider
    }
    
    // MARK: - Public Functions
    
    func buildFromRootWidget(_ widget: Widget) -> UIView {
        let renderer = rendererProvider.buildRenderer(for: widget)
        return renderer.buildView()
    }
    
}
