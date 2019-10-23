//
//  LayoutViewRendererProvider.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 16/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

protocol LayoutViewRendererProvider: FailableWidgetRendererProvider {}

final class LayoutViewRendererProviding: LayoutViewRendererProvider {
    
    func buildRenderer(for widget: Widget) throws -> WidgetViewRendererProtocol {
        switch widget {
        case is FlexSingleWidget:
            return try FlexSingleWidgetViewRenderer(widget)
        case is FlexWidget:
            return try FlexWidgetViewRenderer(widget)
        case is Container:
            return try ContainerWidgetViewRenderer(widget)
        case is Spacer:
            return try SpacerWidgetViewRenderer(widget)
        default:
            throw FailableWidgetRendererProviderError.couldNotFindRenrererForWidget(widget)
        }
    }
    
}
