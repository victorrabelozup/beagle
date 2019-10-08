//
//  FailableWidgetRendererProvider.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 08/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

protocol FailableWidgetRendererProvider {
    func buildRenderer(for widget: Widget) throws -> WidgetViewRenderer
}
