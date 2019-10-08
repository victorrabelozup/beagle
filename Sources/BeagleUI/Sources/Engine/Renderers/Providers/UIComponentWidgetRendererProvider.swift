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
            debugPrint("Button")
        case is DropDown:
            debugPrint("DropDown")
        case is Image:
            debugPrint("Image")
        case is ListView:
            debugPrint("ListView")
        case is SelectView:
            debugPrint("SelectView")
        case is Text:
            debugPrint("Text")
        case is TextField:
            debugPrint("TextField")
        case is ToolBar:
            debugPrint("ToolBar")
        default:
            throw NSError()
        }
    }

}
