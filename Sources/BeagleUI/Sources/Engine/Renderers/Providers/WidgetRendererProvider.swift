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
    
    
    
    // MARK: -
    
    func buildRenderer(for widget: Widget) -> WidgetViewRenderer {
        
    }
    
}
