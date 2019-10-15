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
    private let customWidgetsProvider: CustomWidgetsRendererProviderDequeuing
    
    // MARK: - Initialization
    
    init(
        layoutRendererProvider: LayoutWidgetRendererProvider = LayoutWidgetRendererProviding(),
        uiComponentRendererProvider: UIComponentWidgetRendererProvider = UIComponentWidgetRendererProviding(),
        customWidgetsProvider: CustomWidgetsRendererProviderDequeuing = Beagle.environment.shared.customWidgetsProvider
    ) {
        self.layoutRendererProvider = layoutRendererProvider
        self.uiComponentRendererProvider = uiComponentRendererProvider
        self.customWidgetsProvider = customWidgetsProvider
    }
    
    // MARK: - Public Methods
    
    func buildRenderer(for widget: Widget) -> WidgetViewRenderer {
        do {
            return try layoutRendererProvider.buildRenderer(for: widget)
        } catch { // Don't treat specific errors for now, just try to provide a UIComponent
            debugPrint("LayoutRendererError: \(error)")
            return provideUIComponentRenderer(for: widget)
        }
    }
    
    // MARK: - Private Methods
    
    private func provideUIComponentRenderer(for widget: Widget) -> WidgetViewRenderer {
        do {
            return try uiComponentRendererProvider.buildRenderer(for: widget)
        } catch {
            debugPrint("UIComponentRendererError: \(error)")
            return provideCustomWidgetRendenrer(for: widget)
        }
    }
    
    private func provideCustomWidgetRendenrer(for widget: Widget) -> WidgetViewRenderer {
        do {
            return try customWidgetsProvider.dequeueRenderer(for: widget)
        } catch { // Don't treat specific errors for now, just return a `UnknownWidgetRenderer`
            debugPrint("CustomWidgetsRendererProvider: \(error)")
            return UnknownWidgetViewRenderer(widget)
        }
    }
    
}
