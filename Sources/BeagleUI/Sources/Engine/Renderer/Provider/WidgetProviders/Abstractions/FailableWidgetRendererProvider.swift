//
//  FailableWidgetRendererProvider.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 08/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

enum FailableWidgetRendererProviderError: Error {
    
    case couldNotFindRenrererForWidget(Widget)
    
    var localizedDescription: String {
        switch self {
        case let .couldNotFindRenrererForWidget(widget):
            return "\(String(describing: widget)) has no renderer's registered, please check this."
        }
    }
    
}

public protocol FailableWidgetRendererProvider {
    func buildRenderer(for widget: Widget) throws -> WidgetViewRendererProtocol
}
