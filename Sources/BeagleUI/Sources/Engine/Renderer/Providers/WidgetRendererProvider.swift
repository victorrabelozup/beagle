//
//  WidgetRendererProvider.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 07/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

protocol WidgetRendererProvider {
    func buildRenderer(for widget: Widget) -> WidgetViewRenderer
}

final class WidgetRendererProviding: WidgetRendererProvider {
    
    // MARK: - Dependencies
    
    private let layoutRendererProvider: LayoutWidgetRendererProvider
    private let uiComponentRendererProvider: UIComponentWidgetRendererProvider
    
    // MARK: - Initialization
    
    init(
        layoutRendererProvider: LayoutWidgetRendererProvider = LayoutWidgetRendererProviding(),
        uiComponentRendererProvider: UIComponentWidgetRendererProvider = UIComponentWidgetRendererProviding()
    ) {
        self.layoutRendererProvider = layoutRendererProvider
        self.uiComponentRendererProvider = uiComponentRendererProvider
    }
    
    // MARK: - Public Methods
    
    func buildRenderer(for widget: Widget) -> WidgetViewRenderer {
        do {
            return try layoutRendererProvider
        } catch <#pattern#> {
            <#statements#>
        }
    }
    
}
