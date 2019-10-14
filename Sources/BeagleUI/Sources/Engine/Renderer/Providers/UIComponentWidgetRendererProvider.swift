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
            return try ButtonWidgetViewRenderer(widget)
//        case is DropDown:
//            debugPrint("DropDown")
//        case is Image:
//            debugPrint("Image")
//        case is ListView:
//            debugPrint("ListView")
//        case is SelectView:
//            debugPrint("SelectView")
        case is Text:
            return try TextWidgetViewRenderer(widget)
        case is TextField:
            return try TextFieldWidgetViewRenderer(widget)
//        case is ToolBar:
//            debugPrint("ToolBar")
        default:
            throw FailableWidgetRendererProviderError.couldNotFindRenrererForWidget(widget)
        }
    }

}
