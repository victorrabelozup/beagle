//
//  UIComponentRendererProvider.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 16/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

protocol UIComponentViewRendererProvider: FailableWidgetRendererProvider {}

final class UIComponentViewRendererProviding: UIComponentViewRendererProvider {
    
    func buildRenderer(for widget: Widget) throws -> WidgetViewRendererProtocol {
        switch widget {
        case is Button:
            return try ButtonWidgetViewRenderer(widget)
        case is Image:
            return try ImageWidgetViewRenderer(widget)
        case is NetworkImage:
            return try NetworkImageWidgetViewRenderer(widget)
        case is Text:
            return try TextWidgetViewRenderer(widget)
        default:
            throw FailableWidgetRendererProviderError.couldNotFindRenrererForWidget(widget)
        }
    }
    
}
