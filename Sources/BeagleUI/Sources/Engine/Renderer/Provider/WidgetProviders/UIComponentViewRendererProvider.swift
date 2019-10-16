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
