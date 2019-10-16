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
    
}
