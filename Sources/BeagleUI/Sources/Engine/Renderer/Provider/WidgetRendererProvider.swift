//
//  WidgetRendererProvider.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 07/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

protocol WidgetRendererProvider {
    func buildRenderer(for widget: Widget) -> WidgetViewRendererProtocol
}

final class WidgetRendererProviding: WidgetRendererProvider {
    
    // MARK: - Dependencies
    private let customWidgetsProvider: CustomWidgetsRendererProviderDequeuing
    
    // MARK: - Initialization
    
    init(
        customWidgetsProvider: CustomWidgetsRendererProviderDequeuing? = nil
    ) {
        self.customWidgetsProvider = customWidgetsProvider ?? Beagle.environment.shared.customWidgetsProvider
    }
    
    // MARK: - Public Methods
    
    func buildRenderer(for widget: Widget) -> WidgetViewRendererProtocol {
        do {
            return try buildLayoutRenderer(for: widget)
        } catch { // Don't treat specific errors for now, just try to provide a UIComponent
            debugPrint("LayoutRendererError: \(error)")
            return provideUIComponentRenderer(for: widget)
        }
    }
    
    // MARK: - Private Methods
    
    private func provideUIComponentRenderer(for widget: Widget) -> WidgetViewRendererProtocol {
        do {
            return try buildUIComponentsRenderer(for: widget)
        } catch {
            debugPrint("UIComponentRendererError: \(error)")
            return provideCustomWidgetRendenrer(for: widget)
        }
    }
    
    private func provideCustomWidgetRendenrer(for widget: Widget) -> WidgetViewRendererProtocol {
        do {
            return try customWidgetsProvider.dequeueRenderer(for: widget)
        } catch { // Don't treat specific errors for now, just return a `UnknownWidgetRenderer`
            debugPrint("CustomWidgetsRendererProvider: \(error)")
            return UnknownWidgetViewRenderer(widget)
        }
    }
    
    // MARK: - Builders Map
    func buildLayoutRenderer(for widget: Widget) throws -> WidgetViewRendererProtocol {
        switch widget {
            //        case is FlexSingleWidget:
            //            debugPrint("FlexSingleWidget")
            //        case is FlexWidget:
            //            debugPrint("FlexWidget")
            //        case is Container:
            //            debugPrint("Container")
            //        case is Horizontal:
            //            debugPrint("Horizontal")
            //        case is Padding:
            //            debugPrint("Padding")
            //        case is Spacer:
            //            debugPrint("Spacer")
            //        case is Stack:
            //            debugPrint("Stack")
            //        case is Vertical:
        //            debugPrint("Vertical")
        default:
            throw FailableWidgetRendererProviderError.couldNotFindRenrererForWidget(widget)
        }
    }
    
    func buildUIComponentsRenderer(for widget: Widget) throws -> WidgetViewRendererProtocol {
        switch widget {
        case is Button:
            // TODO: Check what is better...
            // Injecting self or creating a new instance of `WidgetRendererProviding` to inject on the renderer
            return try ButtonWidgetViewRenderer(widget) 
            //        case is Image:
            //            debugPrint("Image")
            //        case is NetworkImage:
            //            debugPrint("NetworkImage")
            //        case is ListView:
        //            debugPrint("ListView")
        case is Text:
            return try TextWidgetViewRenderer(widget)
        default:
            throw FailableWidgetRendererProviderError.couldNotFindRenrererForWidget(widget)
        }
    }
    
}
