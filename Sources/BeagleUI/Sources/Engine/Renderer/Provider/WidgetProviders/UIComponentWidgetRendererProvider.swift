//
//  UIComponentWidgetRendererProvider.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 07/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

protocol UIComponentWidgetRendererProvider: FailableWidgetRendererProvider {}

final class UIComponentWidgetRendererProviding: UIComponentWidgetRendererProvider {
    
    func buildRenderer(for widget: Widget) throws -> WidgetViewRenderer {
        switch widget {
        case is Button:
            return try ButtonWidgetViewRenderer(widget)//        case is Image:
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
