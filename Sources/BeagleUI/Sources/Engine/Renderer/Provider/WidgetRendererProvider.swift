//
//  WidgetRendererProvider.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 07/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

public protocol WidgetRendererProvider {
    func buildRenderer(for widget: Widget) -> WidgetViewRendererProtocol
}

final class WidgetRendererProviding: WidgetRendererProvider {
    
    // MARK: - Dependencies
    
    private let layoutViewRendererProvider: LayoutViewRendererProvider
    private let uiComponentViewRendererProvider: UIComponentViewRendererProvider
    private let customWidgetsProvider: CustomWidgetsRendererProviderDequeuing
    
    // MARK: - Initialization
    
    init(
        layoutViewRendererProvider: LayoutViewRendererProvider = LayoutViewRendererProviding(),
        uiComponentViewRendererProvider: UIComponentViewRendererProvider = UIComponentViewRendererProviding(),
        customWidgetsProvider: CustomWidgetsRendererProviderDequeuing = Beagle.environment.shared.customWidgetsProvider
    ) {
        self.layoutViewRendererProvider = layoutViewRendererProvider
        self.uiComponentViewRendererProvider = uiComponentViewRendererProvider
        self.customWidgetsProvider = customWidgetsProvider
    }
    
    // MARK: - Public Methods
    
    func buildRenderer(for widget: Widget) -> WidgetViewRendererProtocol {
        do {
            let layoutRenderer = try layoutViewRendererProvider.buildRenderer(for: widget)
            return layoutRenderer
        } catch { // Don't treat specific errors for now, just try to provide a UIComponent
            return provideUIComponentRenderer(for: widget)
        }
    }
    
    // MARK: - Private Methods
    
    private func provideUIComponentRenderer(for widget: Widget) -> WidgetViewRendererProtocol {
        do {
            let uiComponentRenderer = try uiComponentViewRendererProvider.buildRenderer(for: widget)
            return uiComponentRenderer
        } catch {
            return provideCustomWidgetRendenrer(for: widget)
        }
    }
    
    private func provideCustomWidgetRendenrer(for widget: Widget) -> WidgetViewRendererProtocol {
        do {
            let customWidgetRenderer = try customWidgetsProvider.dequeueRenderer(for: widget)
            return customWidgetRenderer
        } catch { // Don't treat specific errors for now, just return a `UnknownWidgetRenderer`
            return UnknownWidgetViewRenderer(widget)
        }
    }
    
}
