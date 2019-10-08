//
//  WidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 04/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public enum WidgetViewRenderingError: Error {
    case invalidWidgetType
}

public protocol WidgetViewRenderer {
    init(_ widget: Widget) throws
    func buildView() -> UIView
}
